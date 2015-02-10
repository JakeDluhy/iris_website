class TestObjectivesController < ApplicationController
  before_action :admin_user, only: [:new, :create, :edit, :update]
  
  def index
    @objectives = TestObjective.all
  end

  def new
    @objective = TestObjective.new
  end

  def show
    @objective = TestObjective.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  def create
    @objective = TestObjective.new(objective_params)
    if @objective.save
      flash[:success] = "#{@objective.name} objective created"
      redirect_to @objective
    else
      render 'new'
    end
  end

  def edit
    @objective = TestObjective.find(params[:id])
  end

  def update
    @objective = TestObjective.find(params[:id])
    if @objective.update_attributes(team_params)
      flash[:success] = "TestObjective updated"
      redirect_to @objective
    else
      render 'edit'
    end
  end

  def destroy
    TestObjective.find(params[:id]).destroy
    redirect_to objectives_url
  end

  private

    def objective_params
      params.require(:objective).permit(:test_id, :objective, :expected_result, :result, :status, :completed_date)
    end
end
