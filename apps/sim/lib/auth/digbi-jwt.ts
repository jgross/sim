import { SignJWT, jwtVerify, type JWTPayload } from 'jose'
import { env } from '@/lib/env'
import { createLogger } from '@/lib/logs/console/logger'

const logger = createLogger('DigBI-JWT')

// JWT secret shared between DigBI and Sim
const JWT_SECRET = new TextEncoder().encode(
  env.DIGBI_JWT_SECRET || 'your-shared-jwt-secret-here'
)

export interface DigBIJWTPayload extends JWTPayload {
  sub: string           // User ID from DigBI
  email: string         // User email
  name: string          // User's full name
  admin: boolean        // Admin flag
  first_name?: string   // First name
  last_name?: string    // Last name
  iss: string           // Should be 'digbi'
  aud: string           // Should be 'sim'
}

/**
 * Validate JWT token from DigBI
 */
export async function validateDigBIJWT(token: string): Promise<DigBIJWTPayload | null> {
  try {
    const { payload } = await jwtVerify(token, JWT_SECRET, {
      issuer: 'digbi',
      audience: 'sim',
    })

    logger.info('JWT validation successful', {
      userId: payload.sub,
      email: payload.email,
    })

    return payload as DigBIJWTPayload
  } catch (error) {
    logger.error('JWT validation failed', { error })
    return null
  }
}

/**
 * Generate JWT token (for testing purposes)
 */
export async function generateDigBIJWT(payload: Omit<DigBIJWTPayload, 'iss' | 'aud' | 'iat' | 'exp'>): Promise<string> {
  return new SignJWT(payload)
    .setProtectedHeader({ alg: 'HS256' })
    .setIssuedAt()
    .setIssuer('digbi')
    .setAudience('sim')
    .setExpirationTime('24h')
    .sign(JWT_SECRET)
}

/**
 * Extract JWT token from cookies or Authorization header
 */
export function extractJWTFromRequest(request: Request): string | null {
  // Try Authorization header first
  const authHeader = request.headers.get('Authorization')
  if (authHeader?.startsWith('Bearer ')) {
    return authHeader.slice(7)
  }

  // Try cookies
  const cookieHeader = request.headers.get('Cookie')
  if (cookieHeader) {
    const cookies = parseCookies(cookieHeader)
    return cookies['digbi-auth'] || cookies['digbi_auth'] || null
  }

  return null
}

/**
 * Simple cookie parser
 */
function parseCookies(cookieHeader: string): Record<string, string> {
  const cookies: Record<string, string> = {}
  
  cookieHeader.split(';').forEach(cookie => {
    const [name, value] = cookie.trim().split('=')
    if (name && value) {
      cookies[name] = decodeURIComponent(value)
    }
  })
  
  return cookies
}