class User < ActiveRecord::Base

    def self.authenticate(email, password)
        @user_record = User.where("email=? and password=?", email, password).first
        return @user_record
    end
end
