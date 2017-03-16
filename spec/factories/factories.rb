FactoryGirl.define do
	sequence :slug do |n|
    	"slug#{n}"
  	end #end slug

	factory :category do
	  name "rails"
	end #end category
	 
	factory :pin do
	  title "Rails Cheatsheet"
	  url "http://rails-cheat.com"
	  text "A great tool for beginning developers"
	  slug 
	  category
	end #end :pin

	
  	factory :user do 
	    sequence(:email) { |n| "coder#{n}@skillcrush.com" }
	    first_name "Smart"
	    last_name "Programmer"
	    password "password"
   
   factory :user_with_boards do   	
      after(:create) do |user|
	    3.times do
	      user.pinnings.create(pin: FactoryGirl.create(:pin), board: user.boards.first)
	    end
	  end
    end # end factory :user_with_boards

   factory :user_with_followees do
	   after(:create) do |user|
	     3.times do
	   		Follower.create(user: FactoryGirl.create(:user), follower_id: user.id)
	 	 end
   	    end
 	end #end factory :user_with_followees

   	factory :pinning do
   		pin
   		user
   	end # end factory :pinning

	factory :board do
	  name "My Pins!"  
	end # end factory :board
	end # end factory :user
end # end FactoryGirl.define

