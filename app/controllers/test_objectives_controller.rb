class TestObjectivesController < ApplicationController
  before_action :admin_user, only: [:new, :create, :edit, :update]
  skip_before_action :verify_authenticity_token, only: [:create]
  
  def index
    @objectives = TestObjective.all
  end

  def new
    @objective = TestObjective.new
  end

  def show
    @objective = TestObjective.find(params[:id])
    @assignment = TestAssignment.new
    @comment = TestComment.new
    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  def create
    @objective = TestObjective.new(objective_params)
    if @objective.save
      params["test_objective"]["users"].each do |id|
        unless id.blank?
          TestAssignment.create({:test_objective_id => @objective.id, :user_id => id})
        end
      end
      respond_to do |format|
        format.html { redirect_to @objective.test }
        format.json { render json: @objective.to_json }
       end
    else
      render 'new'
    end
  end

  def edit
    @objective = TestObjective.find(params[:id])
    @users = User.order('name').pluck(:name, :id)
  end

  def update
    @objective = TestObjective.find(params[:id])
    if(@objective.status == 'incomplete' and params[:test_objective][:status] == 'completed')
      @objective.update_attributes({:completer_id => current_user.id})
    end
    if @objective.update_attributes(objective_params)
      unless params[:test_objective][:pictures].nil?
        params[:test_objective][:pictures].each do |picture|
          PictureAttachment.create({avatar: picture, imageable: @objective})
        end
      end
      unless params[:test_objective][:videos].nil?
        @objective.videos.delete_all
        videos = params[:test_objective][:videos].each_line do |video|
          VideoAttachment.create({url: video.sub("watch?v=","embed/"), video: @objective})
        end
      end
      flash[:success] = "Test Objective updated"
      redirect_to @objective.test
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
      params.require(:test_objective).permit(:test_id, :objective, :expected_result, :result, :status, :completed_date, :completer_id)
    end
end
