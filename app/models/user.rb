class User < ActiveRecord::Base
	attr_reader :username

	has_secure_password
	has_many :bills

	def validate
		!User.all.any? { |u| u.username == username}
	end
	
end

# params = {username: "becky567", password: "123"}
# user2 = User.new(username: "becky567", password: "123")