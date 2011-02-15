class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
      
      if @user.save
        redirect_to root_path, :notice => "User was successfully created."
      else
        render :action => "new"
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to root_path, :notice => "User details were successfully updated."
    else
      render :action => "edit"
    end
  end
end
