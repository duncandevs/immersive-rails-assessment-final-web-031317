class AppearancesController < ApplicationController
  before_action :require_login , only:[:new, :edit]

  def new
    @appearance = Appearance.new
  end

  def create
    @appearance = Appearance.new(appearance_params)
    if @appearance.save
      redirect_to @appearance.episode
    else
      redirect_to new_appearance_path
    end
  end

  def edit
    @appearance = Appearance.find(params[:id])
  end

  def update
    @appearance = Appearance.find(params[:id])
    @appearance.update(rating: params[:appearance][:rating], user_id: params[:appearance][:user_id])
    if @appearance.valid?
      redirect_to @appearance.episode
    else
      redirect_to edit_appearance_path
    end
  end

  private

  def appearance_params
    params.require(:appearance).permit(:guest_id, :episode_id, :rating, :user_id)
  end

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end

end
