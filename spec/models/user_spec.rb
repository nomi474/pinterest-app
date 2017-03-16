require 'spec_helper'
#require 'shoulda-matcher'

RSpec.describe User, type: :model do
before(:all) do
  @user = User.create(first_name: "hello", last_name: "world", email: "coder@skillcrush", password: "password")
end
 
after(:all) do
  if !@user.destroyed?
    @user.destroy
  end
end
 
it 'authenticates and returns a user when valid email and password passed in' do
	  authenticate_user = User.authenticate(@user.email,@user.password)
      expect(authenticate_user).to eql(@user)
 
end
    	it { should validate_presence_of(:first_name) }
    	it { should validate_presence_of(:last_name) }
    	it { should validate_presence_of(:email) }
    	it { should validate_presence_of(:password) }

end
