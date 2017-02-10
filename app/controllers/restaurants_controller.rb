class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /restaurants
  # GET /restaurants.json
  def index
    if params[:search]
      @restaurants = Restaurant.where('name LIKE ? OR address LIKE ? OR phone1 LIKE ? OR phone2 LIKE ? OR note LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    elsif params[:category].blank?
      @restaurants = Restaurant.all
    else
      @categories = Category.all
      @restaurants = []
      (Restaurant.all).each do |restaurant|
        if restaurant.category_ids.include?(@categories.find_by_name(params[:category]).id)
          @restaurants.push(restaurant)
        end
      end
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @hash = Gmaps4rails.build_markers(@restaurant) do |restaurant, marker|
        marker.lat restaurant.latitude
        marker.lng restaurant.longitude
        marker.infowindow restaurant.address
    end     
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
      @restaurant.upvote_by current_user
      redirect_to :back
  end

  def downvote
      @restaurant.downvote_by current_user
      redirect_to :back       
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    params.require(:restaurant).permit(:website, :imageURL, :menu_url, :image, :name, :address, :phone1, :phone2, :note, :vegetarian, :category_ids => [] )
  end
end
