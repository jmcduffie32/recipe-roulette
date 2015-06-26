module Api
  class RecipesController < ApplicationController
    def index
      recipes = Recipe.all

      if rating = params[:rating]
        recipes = recipes.where(rating: rating)
      end
      if params[:random]
        recipes = Recipe.order("RANDOM()").limit(5)
      end
      render json: recipes, status: 200
    end

    def show
      recipe = Recipe.find(params[:id])
      render json: recipe, status: 200
    end

    def create
      recipe = Recipe.new(recipe_params)
      if recipe.save
        render json: recipe, status: 201#, location: recipe
      else
        render json: recipe.errors, status: 422
      end
    end

    def update
      recipe = Recipe.find(params[:id])
      if recipe.update(recipe_params)
        render json: recipe, status: 200
      else
        render json: recipe.errors, status: 422
      end
    end

    def destroy
      recipe = Recipe.find(params[:id])
      recipe.destroy!

      render nothing: true, status: 204
    end


    def recipe_params
      params.require(:recipe).permit(:name, :rating, :description)
    end
  end
end
