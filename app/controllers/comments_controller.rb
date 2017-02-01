class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @restaurant = Restaurant.find(params[:restaurant_id])
        @comment = Comment.create(params[:comment].permit(:content))
        @comment.user_id = current_user.id
        @comment.restaurant_id = @restaurant.id

        if @comment.save
            redirect_to restaurant_path(@restaurant)
        else
            render 'new'
        end
    end	

	def show
	    @comments = Comment.where(restaurant_id: @restaurant)
	end 

	def destroy
		@restaurant = Restaurant.find(params[:restaurant_id])
		@comment = @restaurant.comments.find(params[:id])
		@comment.destroy

		redirect_to restaurant_path(@restaurant)
	end	   
end
