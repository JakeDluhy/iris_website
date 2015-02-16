class TestsController < ApplicationController
  before_action :admin_user, only: [:new, :create, :edit, :update]
  
  def index
    @tests = Test.all
  end

  def new
    @test = Test.new
    @subteams = Subteam.all
  end

  def show
    @test = Test.find(params[:id])
    @objectives = @test.test_objectives
    @all_users = []
    @team_lead = @test.subteam.team.team_lead
    @objectives.each do |obj|
      obj.users.each do |user|
        @all_users.push(user) unless @all_users.include?(user) or user == @team_lead
      end
    end
    @users = User.order('name').pluck(:name, :id)
    @completed_count = @objectives.where(:status => 'completed').count
    @incomplete_count = @objectives.where(:status => 'incomplete').count
    @objective = TestObjective.new
    @comment = TestComment.new
    @assignment = TestAssignment.new

    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      flash[:success] = "#{@test.name} test created"
      redirect_to @test
    else
      render 'new'
    end
  end

  def edit
    @test = Test.find(params[:id])
  end

  def update
    @test = Test.find(params[:id])
    if @test.update_attributes(team_params)
      flash[:success] = "Test updated"
      redirect_to @test
    else
      render 'edit'
    end
  end

  def destroy
    Test.find(params[:id]).destroy
    redirect_to tests_url
  end

  private

    def test_params
      params.require(:test).permit(:name, :subteam_id, :test_date, :robot_version)
    end
end
