class TestsController < ApplicationController
  before_action :admin_user, only: [:new, :create, :edit, :update]
  
  def index
    @tests = Test.all
  end

  def new
    @test = Test.new
    @teams = Team.all
  end

  def edit
    @test = Test.find(params[:id])
    @teams = Team.all
  end

  def show
    @test = Test.find(params[:id])
    @other_tests = Test.where("ID != ?", params[:id])
    @objectives = @test.test_objectives
    @all_users = []
    @team_lead = @test.team.team_lead unless @test.team.nil?
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
    @test.robot_version = 5
    if @test.save
      redirect_to @test
    else
      render 'new'
    end
  end

  def update
    @test = Test.find(params[:id])
    if @test.update_attributes(test_params)
      redirect_to @test
    else
      render 'edit'
    end
  end

  def destroy
    test = Test.find(params[:id]).destroy
    redirect_to root_url
  end

  private

    def test_params
      params.require(:test).permit(:name, :team_id, :test_date)
    end
end
