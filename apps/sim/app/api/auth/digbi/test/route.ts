import { NextRequest, NextResponse } from 'next/server'
import { validateDigBIJWT, extractJWTFromRequest, generateDigBIJWT } from '@/lib/auth/digbi-jwt'
import { syncUserFromDigBI } from '@/lib/auth/user-sync'

/**
 * Test endpoint for DigBI JWT authentication
 * GET: Test JWT validation with existing token
 * POST: Generate test JWT token
 */

export async function GET(request: NextRequest) {
  try {
    // Extract JWT from request
    const token = extractJWTFromRequest(request)
    
    if (!token) {
      return NextResponse.json(
        { error: 'No DigBI JWT token found in request' },
        { status: 401 }
      )
    }

    // Validate JWT
    const payload = await validateDigBIJWT(token)
    
    if (!payload) {
      return NextResponse.json(
        { error: 'Invalid DigBI JWT token' },
        { status: 401 }
      )
    }

    // Try to sync user
    try {
      const user = await syncUserFromDigBI(payload)
      
      return NextResponse.json({
        message: 'DigBI JWT validation successful',
        payload,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
        }
      })
    } catch (syncError) {
      return NextResponse.json({
        message: 'JWT valid but user sync failed',
        payload,
        syncError: syncError instanceof Error ? syncError.message : String(syncError)
      })
    }
  } catch (error) {
    return NextResponse.json(
      { error: 'Internal server error', details: error instanceof Error ? error.message : String(error) },
      { status: 500 }
    )
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { email, name, admin = false, first_name, last_name } = body

    if (!email || !name) {
      return NextResponse.json(
        { error: 'email and name are required' },
        { status: 400 }
      )
    }

    // Generate test JWT token
    const token = await generateDigBIJWT({
      sub: `digbi_user_${Date.now()}`,
      email,
      name,
      admin,
      first_name,
      last_name,
    })

    const response = NextResponse.json({
      message: 'Test JWT token generated',
      token,
      usage: {
        cookie: `Set this as 'digbi-auth' cookie`,
        header: `Authorization: Bearer ${token}`,
        test_url: '/api/auth/digbi/test (GET)'
      }
    })

    // Set the cookie for immediate testing
    response.cookies.set('digbi-auth', token, {
      httpOnly: false, // Allow reading in browser for testing
      secure: false,   // Allow in development
      sameSite: 'lax',
      path: '/',
      maxAge: 24 * 60 * 60 // 24 hours
    })

    return response
  } catch (error) {
    return NextResponse.json(
      { error: 'Failed to generate JWT token', details: error instanceof Error ? error.message : String(error) },
      { status: 500 }
    )
  }
}