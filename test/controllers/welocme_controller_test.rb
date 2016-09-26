require 'test_helper'

class WelocmeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
