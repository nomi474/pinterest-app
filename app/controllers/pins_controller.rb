class PinsController < ApplicationController
before_action :require_login, except: [:index, :show, :show_by_name]  
before_action :set_pin, only: [:show, :edit, :update, :repin, :destroy] 
  def index    
      #@pins = current_user.pins
      @pins = Pin.all
  end
  
  def show
    @users = @pin.users
  end
  
  def show_by_name
  	@pin = Pin.find_by_slug(params[:slug])
    @users = @pin.users
  	render :show
  end

  def new
  	@pin = Pin.new
    @pin.pinnings.build
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
    render :edit
  end

  def update    
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

=begin
  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to pins_url, notice: 'Pin was successfully deleted.' }
      format.json { head :no_content }
    end
  end
=end
  private
 
  # Use callbacks to share common setup or constraints between actions.
  def set_pin
     @pin = Pin.find(params[:id])
  end

  def pin_params
    params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id)
  end

end