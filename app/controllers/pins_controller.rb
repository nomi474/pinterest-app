class PinsController < ApplicationController
  # I need to add the index some how for before_action :require_login
  #https://learn.skillcrush.com/skill-challenges/users-pins/
before_action :require_login, only: [:index], except: [:show, :show_by_name]  
  
  def index
    #@pins = current_user.pins
    @pins = Pin.all
  end
  
  def show
    @pin = Pin.find(params[:id])
    @users = @pin.users
  end
  
  def show_by_name
  	@pin = Pin.find_by_slug(params[:slug])
    @users = @pin.users
  	render :show
  end

  def new
  	@pin = Pin.new
  	render :new
  end

  def create 			
	@pin = current_user.pins.create(pin_params)
  	if @pin.valid?
  		@pin.save
  		redirect_to pin_path(@pin)
  	else
  		@errors = @pin.errors
  		render :new
  	end	
  end

  def edit
    @pin = Pin.find(params[:id])
    render :edit
  end

  def update
    @pin = Pin.find(params[:id])
    
    if @pin.update_attributes(pin_params)
      #@pin.save
      redirect_to pin_path(@pin)
    else
      @errors = @pin.errors
      render :edit
    end
  end

  def repin
    @pin = Pin.find(params[:id])
    @pin.pinnings.create(user: current_user)
    redirect_to user_path(current_user)
  end  

  private
 
  def pin_params
    params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id)
  end
end