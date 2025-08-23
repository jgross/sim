import { eq } from 'drizzle-orm'
import { v4 as uuidv4 } from 'uuid'
import { db } from '@/db'
import * as schema from '@/db/schema'
import { createLogger } from '@/lib/logs/console/logger'
import type { DigBIJWTPayload } from './digbi-jwt'

const logger = createLogger('UserSync')

/**
 * Sync user from DigBI to Sim database
 * Creates a new user if they don't exist, updates if they do
 */
export async function syncUserFromDigBI(jwtPayload: DigBIJWTPayload) {
  try {
    const { sub: digbiUserId, email, name, admin, first_name, last_name } = jwtPayload

    // Check if user already exists by email
    const existingUser = await db
      .select()
      .from(schema.user)
      .where(eq(schema.user.email, email))
      .limit(1)

    const fullName = name || [first_name, last_name].filter(Boolean).join(' ') || email
    
    if (existingUser.length > 0) {
      // Update existing user
      const user = existingUser[0]
      
      const updatedUser = await db
        .update(schema.user)
        .set({
          name: fullName,
          updatedAt: new Date(),
        })
        .where(eq(schema.user.id, user.id))
        .returning()

      logger.info('Updated existing user from DigBI', {
        userId: user.id,
        email: email,
        digbiUserId,
      })

      return updatedUser[0]
    } else {
      // Create new user
      const newUserId = uuidv4()
      
      const newUser = await db
        .insert(schema.user)
        .values({
          id: newUserId,
          name: fullName,
          email: email,
          emailVerified: true, // DigBI users are already verified
          createdAt: new Date(),
          updatedAt: new Date(),
          image: null, // Could be added later if DigBI has avatars
        })
        .returning()

      // Create default organization for the user if they're admin
      if (admin) {
        const orgId = uuidv4()
        
        await db.insert(schema.organization).values({
          id: orgId,
          name: `${fullName}'s Organization`,
          userId: newUserId,
          slug: `${email.split('@')[0]}-${Date.now()}`,
          createdAt: new Date(),
          updatedAt: new Date(),
        })

        await db.insert(schema.member).values({
          id: uuidv4(),
          organizationId: orgId,
          userId: newUserId,
          role: 'admin',
          createdAt: new Date(),
          updatedAt: new Date(),
        })
      }

      logger.info('Created new user from DigBI', {
        userId: newUserId,
        email: email,
        digbiUserId,
        admin,
      })

      return newUser[0]
    }
  } catch (error) {
    logger.error('Failed to sync user from DigBI', {
      error,
      email: jwtPayload.email,
    })
    throw error
  }
}

/**
 * Get or create user session for DigBI user
 */
export async function getOrCreateSessionForDigBIUser(user: typeof schema.user.$inferSelect, activeOrgId?: string) {
  try {
    // Check if user has an active session
    const existingSessions = await db
      .select()
      .from(schema.session)
      .where(eq(schema.session.userId, user.id))
      .orderBy(schema.session.createdAt)
      .limit(1)

    // Clean up expired sessions
    await db
      .delete(schema.session)
      .where(eq(schema.session.userId, user.id))
      // Only delete sessions that are expired (older than 30 days)

    // Create new session
    const sessionId = uuidv4()
    const sessionToken = generateSessionToken()
    
    const newSession = await db
      .insert(schema.session)
      .values({
        id: sessionId,
        userId: user.id,
        token: sessionToken,
        expiresAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000), // 30 days
        createdAt: new Date(),
        updatedAt: new Date(),
        activeOrganizationId: activeOrgId,
        ipAddress: null,
        userAgent: null,
      })
      .returning()

    logger.info('Created session for DigBI user', {
      userId: user.id,
      sessionId,
    })

    return newSession[0]
  } catch (error) {
    logger.error('Failed to create session for DigBI user', {
      error,
      userId: user.id,
    })
    throw error
  }
}

/**
 * Generate a secure session token
 */
function generateSessionToken(): string {
  const charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
  let result = ''
  for (let i = 0; i < 128; i++) {
    result += charset.charAt(Math.floor(Math.random() * charset.length))
  }
  return result
}