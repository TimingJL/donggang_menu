class CategoriesController < ApplicationController
	before_action :find_category, only: [:show, :edit, :update, :destroy]

	def index
		@categories = Category.all
	end

    def show
    	redirect_to @category
    end

	def new
		@category = Category.new
	end

	def edit
	end

	def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to @category
        else
            render 'new'
        end		
	end

	def update
		respond_to do |format|
		  if @category.update(category_params)
		    format.html { redirect_to @category, notice: 'Category was successfully updated.' }
		    format.json { render :show, status: :ok, location: @category }
		  else
		    format.html { render :edit }
		    format.json { render json: @category.errors, status: :unprocessable_entity }
		  end
		end
	end

	def destroy
        if @category.destroy
            flash[:success] = "Category was deleted."
        else
            flash[:error] = "Category could not be deleted."
        end
        redirect_to @category		
	end

	private

    def find_category
        @category = Category.find(params[:id])
    end

	def category_params
		params.require(:category).permit(:name)
	end
end
