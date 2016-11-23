require 'spec_helper'
RSpec.describe PinsController do
	describe "GET index" do
 
      it 'renders the index template' do
        get :index
        expect(response).to render_template("index")
      end
    
       it 'populates @pins with all pins' do
	      get :index
	      expect(assigns[:pins]).to eq(Pin.all)
	   end
	end

	describe "GET new" do
    it 'responds with successfully' do
      get :new
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
        category_id: 2}    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
  	# responds with success
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