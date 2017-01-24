class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_venues = Venue.where(user_id: params[:id])
  end
end
