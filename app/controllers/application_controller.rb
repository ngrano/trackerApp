class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_with_api_key
    api_key = params[:apikey]
    @user = User.find_by_apikey(api_key)

    unless @user
      render :json => {}, :status => :unauthorized
    end
  end
end
