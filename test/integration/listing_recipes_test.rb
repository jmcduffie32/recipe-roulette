require 'test_helper'

class ListingrecipesTest < ActionDispatch::IntegrationTest
  setup do
    Recipe.create!(name: "Eggdrop Soup", rating: 5)
    Recipe.create!(name: "Pizzia", rating: 4)
  end

  test 'listing recipes' do
    get '/recipes'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal Recipe.count, json(response.body)[:recipes].size
  end

  test 'should list top rated recipes' do
    get '/recipes?rating=5'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, json(response.body)[:recipes].size
  end
end
