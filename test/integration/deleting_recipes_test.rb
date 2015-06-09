require 'test_helper'

class DeletingRecipesTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = Recipe.create!(name: 'Egg Drop Soup')
  end
  test 'should delete recipes' do
    delete "/recipes/#{@recipe.id}"

    assert_equal 204, response.status
  end
end
