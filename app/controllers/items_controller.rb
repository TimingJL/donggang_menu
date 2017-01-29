class ItemsController < ApplicationController
	before_action :set_restaurant

    def create
        @item = @restaurant.items.create(item_params)
        @item.save         
        redirect_to @restaurant
    end

    def new
        @item = Item.new
    end

    def edit
        @item = Item.find(params[:id])
    end

    def update
        @item = Item.find(params[:id])
        if @item.update(item_params)
            redirect_to @restaurant
        else
            render 'edit'
        end
    end

    def destroy
        @item = @restaurant.items.find(params[:id])
        if @item.destroy
            flash[:success] = "Restaurant item was deleted."
        else
            flash[:error] = "Restaurant item could not be deleted."
        end
        redirect_to @restaurant
    end    

    private

    def set_restaurant
        @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def item_params
        params[:item].permit(:name, :price, :imageURL, :vegetarian, :note, :count, :rating, :score, :restaurant_id)
    end	
end
