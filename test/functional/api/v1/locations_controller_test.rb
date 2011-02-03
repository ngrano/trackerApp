require 'test_helper'

class Api::V1::LocationsControllerTest < ActionController::TestCase
  def setup
    @user = Factory.create(:user)
  end

  test "return error if apikey was invalid" do
    post :create, :location => { }, :apikey => 'invalid'
    assert_response :unauthorized
  end

  test "create a location by json request" do
    data = {:longtitude => 50.12312313, :latitude => 62.12312323}
    post :create, :location => data, :format => :json, :apikey => @user.apikey
    assert_response :success
    response_data = ActiveSupport::JSON.decode(@response.body)
    assert_equal 50.12312313, response_data['location']['longtitude'].to_f
  end
end