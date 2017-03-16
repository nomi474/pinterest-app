require 'spec_helper'

RSpec.describe PinsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  before(:each) do 
    @user = FactoryGirl.build(:user_with_boards)
    login(@user)
    @category = FactoryGirl.create(:category)
    @pins = @user.pins
    #@board = @user.boards.first
    #@board_pinner = BoardPinner.create(user: @user, board: FactoryGirl.create(:board))
    #@pin = FactoryGirl.create(:pin)
  end
  
  after(:each) do
    if !@user.destroyed?
      @user.pinnings.destroy_all
      @user.boards.destroy_all
      #@user.pins.destroy_all
      @user.destroy
    end

    category = Category.find_by_name("rails")
      if !category.nil?
         category.destroy
    end  
  end

  let(:valid_attributes) {
    {
    first_name: @user.first_name,
    last_name: @user.last_name,
    email: @user.email,
    password: @user.password
    }
  }

  let(:invalid_attributes) {
    {
    first_name: @user.first_name,
    password: @user.password
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }


	describe "GET index" do     
      it 'renders the index template' do
        user = User.create! valid_attributes
        get :index, {:id => user.to_param}, valid_session
        expect(response).to render_template(:index)
      end
   
       it 'populates @pins with all pins' do
	      get :index
        expect(assigns[:pins]).to eq(Pin.all)
	     end           
	end

	describe "GET new" do
    it 'responds with successfully' do
      #user = User.create! valid_attributes
      get :new #, {}, valid_session
      expect(response.success?).to be(true)
    end
    
    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end
  end
  
  describe "POST create" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: 2}    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    
    it 'responds with a redirect following a POST to /pins' do
      post :create, pin: @pin_hash
      expect(response.redirect?).to be(true)
    end
    
    it 'creates a pin' do
      post :create, pin: @pin_hash  
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end
    
    it 'redirects to the show view' do
      post :create, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
    
    it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(response).to render_template(:new)
    end
    
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(assigns[:errors].present?).to be(true)
    end    
    
  end
  
  describe "GET edit" do	
  	before(:each) do
  		@pin = Pin.find_by_slug("rails-tutorial")
  	end
		# get to /pins/id/edit
		# responds successfully
		it 'responds with successfully' do
		  get :edit, :id => @pin.id
		  expect(response.success?).to be(true)
		end
		
		# renders the edit template
		it 'renders the edit view' do
		  get :edit, :id => @pin.id     
		  expect(response).to render_template(:edit)
		end

		it 'assigns an intance variable called pin to the Pin with the appropriate id' do
		  get :edit, :id => @pin.id 
		  expect(@pin).to be_an_instance_of(Pin)
		end
	end
  # making a POST request to /pins with valid parameters
  describe "POST update with valid parameters" do
	before(:each) do
	  @pin = Pin.first
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: 2
      }    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
  	# responds with a redirect
  	it 'responds with success' do
	  post :update, pin: @pin_hash, id: @pin.id
      expect(response.redirect?).to be(true)
  	end
  		
  	# updates a pin
  	it 'updates a pin' do
	  post :update, pin: @pin_hash, id: @pin.id
	  expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
  	end
  	
  	# redirects to the show view	
  	it 'redirects to the show view' do
	  post :update, pin: @pin_hash, id: @pin.id
      expect(response).to redirect_to(pin_url(assigns(:pin)))  	
  	end
  end
    
  # making a POST request to /pins with invalid parameters
  describe "POST update with invalid parameters" do
	before(:each) do
	  @pin = Pin.first	
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: 2}   
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
  	# assigns an @errors instance variable
  	it 'assigns an @errors instance variable' do
	  @pin_hash[:title] = ""
	  post :update, pin: @pin_hash, id: @pin.id
	  expect(assigns[:errors].present?).to be(true)
  	end
  	
  	# renders the edit view
  	it 'renders the edit view' do
      @pin_hash[:title] = ""
	  post :update, pin: @pin_hash, id: @pin.id
      expect(response).to render_template(:edit)	
  	end
  end
end