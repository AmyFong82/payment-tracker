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
				"Please use another username"
			end
		else
			"Please fill in all the fields!"
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
		else
			redirect '/login'
			"flash message"
		end
	end

	
end