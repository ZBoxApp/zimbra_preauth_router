require 'sinatra/base'
require "sinatra/cookies"
require File.expand_path '../lib/zimbra_pre_auth_router.rb', __FILE__


class App < Sinatra::Base
  helpers Sinatra::Cookies
  
  configure :production, :development do
    enable :logging
    enable :session
  end
  
  get '/' do
    @login_error = params[:login_error]
    erb :index
  end
  
  post '/login' do
    user = ZimbraPreAuthRouter::User.new(params[:username], params[:password])
    login = user.login
    logger.info "Authenticating #{user.email} agains #{user.backend_url}"
    if login.valid?
      logger.info "Auth OK: redirecting #{user.email} to #{user.backend_url}"
      redirect to("#{user.backend_url}/#{user.preatuh_url}")
    else
      logger.info "Auth Failed for #{user.email}"
      redirect to("/?login_error=true")
    end
  end

  run! if app_file == $0
  
end