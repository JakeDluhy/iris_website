class SubteamsController < ApplicationController
  def index
    @subteams = Subteam.all
  end

  def new
    @subteam = Subteam.new
    @teams = Team.all
  end

  def show
    @subteam = Subteam.find(params[:id])
  end

  def create
    @subteam = Subteam.new(subteam_params)
    if @subteam.save
      flash[:success] = "Subteam created"
      redirect_to @subteam
    else
      render 'new'
    end
  end

  def destory
    subteam = Subteam.find(params[:id]).destroy
    redirect_to subteam.team
  end

  private

    def subteam_params
      params.require(:subteam).permit(:name, :description, :team_id)
    end
end
