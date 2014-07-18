class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :non_signed_in_user, only: [:new, :create]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    if @user.subteams.exists?
      @subteams = @user.subteams
      @other_subteams = Subteam.where('id NOT IN (?)', @subteams.pluck(:id))
    else
      @subteams = []
      Subteam.all.exists? ? @other_subteams = Subteam.all : @other_subteams = []
    end
    if @user.teams.exists?
      @teams = @user.teams
      @other_teams = Team.where('id NOT IN (?)', @teams.pluck(:id))
    else
      @teams = []
      Team.all.exists? ? @other_teams = Team.all : @other_teams = []
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user[:avatar] = params[:user][:pictures][0]
      sign_in @user
  		flash[:success] = "Welcome to IRIS!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit

  end

  def update

    if @user.update_attributes(user_params)
      binding.pry
      @user[:avatar] = params[:user][:pictures][0]
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def join_teams
    params[:subteams].each_key { |subteam_id| Subteam.find(subteam_id).add_user_membership(current_user) } unless params[:subteams].nil?
    params[:teams].each_key { |team_id| Team.find(team_id).add_user_membership(current_user) } unless params[:teams].nil?
    response = {}
    response[:subteams] = params[:subteams].keys unless params[:subteams].nil?
    response[:teams] = params[:teams].keys unless params[:teams].nil?
    render :json => response
  end

  private

  	def user_params
      params[:user][:avatar] = params[:user][:pictures][0]
  		params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation)
  	end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def non_signed_in_user
      redirect_to root_url if signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      if (User.find(params[:id]).admin?) || !(current_user.admin?)
        redirect_to(root_url)
      end
    end
end
