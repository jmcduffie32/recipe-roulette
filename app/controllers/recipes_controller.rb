class RecipesController < ApplicationController
  def index
    recipes = Recipe.all

    if rating = params[:rating]
      recipes = recipes.where(rating: rating)
    end
    render json: recipes, status: 200
  end

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      render json: recipe, status: 201, location: recipe
    else
      render json: recipe.errors, status: 422
    end
  end


  def recipe_params
    params.require(:recipe).permit(:name, :rating)
  end
end
