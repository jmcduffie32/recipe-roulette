require 'test_helper'

class ListingRecipiesTest < ActionDispatch::IntegrationTest
  setup do
    Recipe.create!(name: "Eggdrop Soup", rating: 5)
    Recipe.create!(name: "Pizzia", rating: 4)
  end

  test 'listing recipies' do
    get '/recipies'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal Recipe.count, JSON.parse(response.body).size
  end

  test 'should list top rated recipies' do
    get '/recipies?rating=5'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, JSON.parse(response.body).size
  end
end
