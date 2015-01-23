class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :join_teams, :destroy]
  before_action :non_signed_in_user, only: [:new, :create]
  before_action :correct_user,   only: [:edit, :update, :join_teams]
  before_action :admin_user,     only: :destroy
  before_action :target_not_admin, only: :destroy

  def index
    @users = User.order('name ASC').paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    if @user.subteams.exists?
      @subteams, ids = filter_duplicate_subteams(@user.subteams)
      @other_subteams = Subteam.where('id NOT IN (?)', ids)
    else
      @subteams = []
      Subteam.all.exists? ? @other_subteams = Subteam.all : @other_subteams = []
    end
    if @user.teams.exists?
      @teams, ids = filter_duplicate_teams(@user.teams)
      @other_teams = Team.where('id NOT IN (?)', ids)
    else
      @teams = []
      Team.all.exists? ? @other_teams = Team.all : @other_teams = []
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to IRIS!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = current_user
    if @user.subteams.exists?
      @subteams, ids = filter_duplicate_subteams(@user.subteams)
      @other_subteams = Subteam.where('id NOT IN (?)', ids)
    else
      @subteams = []
      Subteam.all.exists? ? @other_subteams = Subteam.all : @other_subteams = []
    end
    if @user.teams.exists?
      @teams, ids = filter_duplicate_teams(@user.teams)
      @other_teams = Team.where('id NOT IN (?)', ids)
    else
      @teams = []
      Team.all.exists? ? @other_teams = Team.all : @other_teams = []
    end
  end

  def update

    if @user.update_attributes(user_params)
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
    redirect_to edit_user_path(@user)
  end

  private

  	def user_params
      params[:user][:avatar] = params[:user][:pictures][0] unless params[:user][:pictures].nil?
  		params.require(:user).permit(:name, :email, :bio, :avatar, :password, :password_confirmation, :major, :year)
  	end

    #Hack to fix duplicate membership mistake
    def filter_duplicate_teams(teams)
      filtered = []
      ids = []
      teams.each do |team|
        unless (ids.include?(team.id))
          filtered.push(Team.find(team.id))
          ids.push(team.id)
        end
      end
      return filtered, ids
    end

    def filter_duplicate_subteams(subteams)
      filtered = []
      ids = []
      subteams.each do |subteam|
        unless (ids.include?(subteam.id))
          filtered.push(Subteam.find(subteam.id))
          ids.push(subteam.id)
        end
      end
      return filtered, ids
    end
end
