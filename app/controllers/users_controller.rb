require 'rack-flash'

class UsersController < ApplicationController

	get '/signup' do
		erb :"/users/create_user"
	end

	post '/signup' do
		if !params.values.any? ("")
			@user = User.new(username: params[:username], email: params[:email], password: params[:password])
			if @user.validate(params)
				@user.save
				session[:user_id] = @user.id 
				redirect "/bills"
			else
				flash[:message] = "Username taken. Please try another one."
  				redirect to ("/signup")
			end
		else
			flash[:message] = "Please fill in all the fields."
  			redirect to ("/signup")
		end
	end

	get '/login' do
		erb :"users/login"
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id 
			redirect '/bills'
		elsif @user && !@user.authenticate(params[:password])
			flash[:message] = "Username or password incorrect."
			redirect '/login'
		else
			flash[:message] = "You do not have an account yet. Please sign up to use."
			redirect '/login'
		end
	end

	get '/logout' do
    	session.destroy
    	redirect '/login'
	end

	
end