class User < ActiveRecord::Base
	attr_reader :username

	has_secure_password
	has_many :bills

	def validate(params)
		!User.all.find_by(username: params[:username]) ? true : false
	end
	
end