# DigBI Rails Implementation for JWT Authentication
# Add this to your DigBI Rails application

# Gemfile - Add JWT gem
# gem 'jwt'

# config/application.rb or config/initializers/jwt.rb
class JWTService
  JWT_SECRET = Rails.application.credentials.dig(:jwt_secret) || ENV['DIGBI_JWT_SECRET'] || 'your-shared-jwt-secret-between-digbi-and-sim'
  ALGORITHM = 'HS256'.freeze
  ISSUER = 'digbi'.freeze
  AUDIENCE = 'sim'.freeze

  def self.encode_for_sim(user)
    payload = {
      sub: user.id.to_s,
      email: user.email,
      name: "#{user.first_name} #{user.last_name}".strip,
      first_name: user.first_name,
      last_name: user.last_name,
      admin: user.admin || false,
      iss: ISSUER,
      aud: AUDIENCE,
      exp: 24.hours.from_now.to_i,
      iat: Time.current.to_i
    }

    JWT.encode(payload, JWT_SECRET, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, JWT_SECRET, true, {
      algorithm: ALGORITHM,
      verify_iss: true,
      iss: ISSUER,
      verify_aud: true,
      aud: AUDIENCE
    })
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT decode error: #{e.message}"
    nil
  end
end

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # ... existing code ...

  # Generate JWT token after successful authentication
  def generate_sim_jwt_token
    return unless current_user
    
    token = JWTService.encode_for_sim(current_user)
    
    # Set cookie for Sim app
    cookies[:digbi_auth] = {
      value: token,
      expires: 24.hours.from_now,
      httponly: false, # Allow JS access for cross-domain scenarios
      secure: Rails.env.production?,
      same_site: :lax,
      domain: extract_root_domain # e.g., '.yourdomain.com' for cross-subdomain access
    }
    
    Rails.logger.info "Generated Sim JWT for user #{current_user.id}"
  end

  private

  def extract_root_domain
    # Extract root domain for cookie sharing
    # e.g., 'app.yourdomain.com' -> '.yourdomain.com'
    host = request.host
    parts = host.split('.')
    
    if parts.length >= 2
      ".#{parts[-2]}.#{parts[-1]}"
    else
      host
    end
  end
end

# app/controllers/sessions_controller.rb (or wherever you handle Devise sessions)
class SessionsController < Devise::SessionsController
  # ... existing code ...

  # Override Devise's sign_in method to generate JWT
  def create
    super do |user|
      if user.persisted?
        generate_sim_jwt_token
        Rails.logger.info "User #{user.email} signed in, JWT token generated for Sim"
      end
    end
  end

  # Also generate JWT on successful registration
  def after_sign_up_path_for(resource)
    generate_sim_jwt_token
    super
  end

  # Clean up JWT token on sign out
  def destroy
    cookies.delete(:digbi_auth, domain: extract_root_domain)
    super
  end
end

# app/controllers/api/sim_controller.rb - API endpoint for Sim integration
class Api::SimController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:generate_token]

  # POST /api/sim/generate_token - Generate JWT token for current user
  def generate_token
    token = JWTService.encode_for_sim(current_user)
    
    render json: {
      token: token,
      user: {
        id: current_user.id,
        email: current_user.email,
        name: "#{current_user.first_name} #{current_user.last_name}".strip,
        admin: current_user.admin
      }
    }
  end

  # GET /api/sim/user_info - Return current user info in Sim-compatible format
  def user_info
    render json: {
      user: {
        id: current_user.id,
        email: current_user.email,
        name: "#{current_user.first_name} #{current_user.last_name}".strip,
        first_name: current_user.first_name,
        last_name: current_user.last_name,
        admin: current_user.admin
      }
    }
  end
end

# config/routes.rb - Add API routes
Rails.application.routes.draw do
  # ... existing routes ...
  
  namespace :api do
    resources :sim, only: [] do
      collection do
        post :generate_token
        get :user_info
      end
    end
  end
end

# Migration to ensure users table has required fields
# rails generate migration AddSimFieldsToUsers admin:boolean first_name:string last_name:string

class AddSimFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, default: false unless column_exists?(:users, :admin)
    add_column :users, :first_name, :string unless column_exists?(:users, :first_name)
    add_column :users, :last_name, :string unless column_exists?(:users, :last_name)
  end
end

# config/credentials.yml.enc - Add JWT secret
# Run: rails credentials:edit
# Add:
# jwt_secret: your-shared-jwt-secret-between-digbi-and-sim

# Example usage in views to redirect to Sim with authentication:
# <%= link_to "Open Sim", "http://sim.yourdomain.com/workspace", 
#     onclick: "fetch('/api/sim/generate_token', {method: 'POST'}).then(() => window.open(this.href))" %>