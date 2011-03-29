class Api::V1::LocationsController < Api::BaseController
  before_filter :authenticate_with_api_key

  def create
    @location = @user.locations.build(params[:location])

    respond_to do |format|
      if @location.save
        format.json { render :json => @location, :status => :ok }
      else
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  def friends
    @locations = User.friends_locations(@user)

    respond_to do |format|
      format.json { render :json => @locations, :status => :ok }
    end
  end
end
