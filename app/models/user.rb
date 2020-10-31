class User < ActiveRecord::Base
	has_secure_password
	has_many :bills

	def initialize(params[:username])
		if !User.all.any? { |u| u.username == username }
			User.create(username: params[:username], email: params[:email], password: params[:password])
		else
			return
		end
	end
	
end