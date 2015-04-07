require 'sinatra/base'
require "sinatra/cookies"
require File.expand_path '../lib/zimbra_pre_auth_router.rb', __FILE__


class App < Sinatra::Base
  helpers Sinatra::Cookies
  
  configure :production, :development do
    enable :logging
  end
  
  enable :session
  
  get '/' do
    erb :index
  end
  
  post '/login' do
    session.delete(:login_error)
    user = ZimbraPreAuthRouter::User.new(params[:username], params[:password])
    login = user.login
    logger.info "Authenticating #{user.email} agains #{user.backend_url}"
    if login.valid?
      logger.info "Auth OK: redirecting #{user.email} to #{user.backend_url}"
      redirect to("#{user.backend_url}/#{user.preatuh_url}")
    else
      logger.info "Auth Failed for #{user.email}"
      session[:login_error] = 'true'
      redirect to("/")
    end
  end

  run! if app_file == $0
  
end