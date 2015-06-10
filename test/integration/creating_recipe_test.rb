require 'test_helper'

class CreatingRecipeTest < ActionDispatch::IntegrationTest
  test 'should create new recipe with valid data' do
    post '/recipes', {recipe:
      {
        name: 'Egg drop soup',
        rating: 5
      }
    }.to_json, {'Accept' => 'application/json', 'Content-Type' => 'application/json'}

    assert_equal 201, response.status
    recipe = json(response.body)
    assert_equal recipe_url(recipe[:id]), response.location

    assert_equal Mime::JSON, response.content_type
    assert_equal 'Egg drop soup', recipe[:name]
    assert_equal 5, recipe[:rating].to_i
  end

  test 'should not create recipe with invalid data' do
    post '/recipes', {recipe:
      {
        name: nil,
        rating: 5
      }
    }.to_json, {'Accept' => 'application/json', 'Content-Type' => 'application/json'}


    assert_equal 422, response.status
  end
end
