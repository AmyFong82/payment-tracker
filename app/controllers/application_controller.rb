require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
	use Rack::Flash
    set :session_secret, "tracker_secret"
    set :views, 'app/views'
  end


  get '/' do
  	if session[:user_id]
  		redirect "/bills"
  	else
  		erb :'index'
  	end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
