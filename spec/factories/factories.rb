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
  end
end 