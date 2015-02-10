class TutorialsController < ApplicationController
  
  def index
    @tutorials = Tutorial.all.order('updated_at DESC')
  end

  def new
    @tutorial = Tutorial.new
    @instruction = Instruction.new
    @subteams = Subteam.all
    @teams = Team.all
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    @instructions = @tutorial.instructions
    @instructions.empty? ? @order_id = 1 : @order_id = @instructions.last.order_id + 1
    @instruction = Instruction.new
  end

  def create
    @tutorial = Tutorial.new(tutorials_params)
    @tutorial[:author_id] = current_user.id
    if @tutorial.save
      flash[:success] = "Tutorial successfully created!"
      redirect_to @tutorial
    else
      render :action => 'new'
    end
  end

  def destroy
    Tutorial.find(params[:id]).destroy
    redirect_to tutorials_url
  end

  private

    def tutorials_params
      params.require(:tutorial).permit(:title, :team_id, :subteam_id)
    end
end
