class RecipiesController < ApplicationController
  def index
    recipies = Recipe.all

    if rating = params[:rating]
      recipies = recipies.where(rating: rating)
    end
    render json: recipies, status: 200
  end
end
