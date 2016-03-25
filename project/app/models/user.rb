class User < ActiveRecord::Base
		# users.password_hash in the database is a :string
 has_secure_password
 validate :password, length:{minimum: 3}

	
	
end

