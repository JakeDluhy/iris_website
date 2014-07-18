class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def show
    @team = Team.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "#{@team.name} created"
      redirect_to @team
    else
      render 'new'
    end
  end

  def destory
    Team.find(params[:id]).destroy
    redirect_to teams_url
  end

  private

    def team_params
      params.require(:team).permit(:name, :description)
    end
end
