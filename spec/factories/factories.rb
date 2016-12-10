FactoryGirl.define do
	factory :category do
	  name "rails"
	end
	 
	factory :pin do
	  title "Rails Cheatsheet"
	  url "http://rails-cheat.com"
	  text "A great tool for beginning developers"
	  slug
	  category
	end
	
  factory :user do 
    sequence(:email) { |n| "coder#{n}@skillcrush.com" }
    first_name "Skillcrush"
    last_name "Coder"
    password "secret"

    factory :user_with_boards do
      after(:create) do |user|
	    3.times do
	      user.pinnings.create(pin: FactoryGirl.create(:pin), board: user.boards.first)
	    end
	  end
   end 

   factory :pinning do
   		pin
   		user
   end
end


