require 'test_helper'

class RestaurantUserRegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get restaurant_user_registrations_new_url
    assert_response :success
  end

end
