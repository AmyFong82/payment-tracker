class User < ActiveRecord::Base
	attr_reader :username

	has_secure_password
	has_many :bills

	def validate(params)
		!User.all.find_by(username: params[:username]) ? true : false
	end
	
end

# params = {username: "becky567", password: "123"}
# params = {username: "becky123", password: "123"}
# user2 = User.new(username: params[:username], password: params[:password])
# user2.validate(params)