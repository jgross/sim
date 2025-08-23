import { NextRequest, NextResponse } from 'next/server'
import { validateDigBIJWT, extractJWTFromRequest } from './digbi-jwt'
import { syncUserFromDigBI, getOrCreateSessionForDigBIUser } from './user-sync'
import { createLogger } from '@/lib/logs/console/logger'

const logger = createLogger('DigBIMiddleware')

/**
 * Middleware to handle DigBI JWT authentication
 * This runs before Better Auth and creates Sim sessions for DigBI users
 */
export async function handleDigBIAuthentication(request: NextRequest): Promise<NextResponse> {
  try {
    // Extract JWT token from request
    const token = extractJWTFromRequest(request)
    
    if (!token) {
      // No DigBI token found, continue with normal flow
      return NextResponse.next()
    }

    // Validate JWT token
    const jwtPayload = await validateDigBIJWT(token)
    
    if (!jwtPayload) {
      // Invalid token, remove it and continue
      logger.warn('Invalid DigBI JWT token, clearing cookie')
      const response = NextResponse.next()
      response.cookies.delete('digbi-auth')
      response.cookies.delete('digbi_auth')
      return response
    }

    // Sync user from DigBI to Sim
    const user = await syncUserFromDigBI(jwtPayload)
    
    // Create or get session for the user
    const session = await getOrCreateSessionForDigBIUser(user)
    
    // Set Better Auth compatible session cookie
    const response = NextResponse.next()
    
    // Set the session cookie that Better Auth expects
    response.cookies.set('better-auth.session_token', session.token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      path: '/',
      maxAge: 30 * 24 * 60 * 60, // 30 days
    })

    // Add user info to request headers for downstream middleware
    response.headers.set('X-User-ID', user.id)
    response.headers.set('X-User-Email', user.email)
    response.headers.set('X-User-Name', user.name)
    response.headers.set('X-DigBI-Auth', 'true')

    logger.info('DigBI authentication successful', {
      userId: user.id,
      email: user.email,
    })

    return response
    
  } catch (error) {
    logger.error('Error in DigBI authentication middleware', { error })
    
    // On error, clear any DigBI cookies and continue
    const response = NextResponse.next()
    response.cookies.delete('digbi-auth')
    response.cookies.delete('digbi_auth')
    return response
  }
}

/**
 * Check if request should be handled by DigBI middleware
 */
export function shouldHandleDigBIAuth(request: NextRequest): boolean {
  const { pathname } = request.nextUrl
  
  // Skip middleware for static files and API routes that don't need auth
  const skipPaths = [
    '/_next/',
    '/favicon.ico',
    '/api/auth/', // Let Better Auth handle its own routes
    '/api/health',
  ]
  
  return !skipPaths.some(path => pathname.startsWith(path))
}