class ProfilesController < ApplicationController
  before_action :get_profile, only: %i[show edit update]
  before_action :authenticate_user!
  before_action :public?, except: %i[private_page new]

  def show
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
            flash[:notice] = 'Profile Created. Welcome!'
      redirect_to @profile
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = 'Task Updated! Go for it!'
      redirect_to @profile
    else
      render :edit
    end
  end

  def change_privacy
    @profile.update(privacy_params)
    redirect_to @profile
  end

  def private_page
  end

  private

  def profile_params
    params.require(:profile).permit(:nickname, :bio, :avatar)
  end

  def privacy_params
    params.require(:profile).permit(:share)
  end

  def find_profile
    @profile = Profile.find(params[:id])
  end

  def public?
    unless (current_user.profile == @profile)
      unless @profile.share
        redirect_to private_page_profile_path(@profile)
      end
    end
  end

end

