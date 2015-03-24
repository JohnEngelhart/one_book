require 'test_helper'

class MainScreenControllerTest < ActionController::TestCase
  test "should get mainScreen" do
    get :mainScreen
    assert_response :success
  end

end
