class TasksController < ApplicationController

  def index
    @tasks = Task.all.order('updated_at DESC')
  end

  def new
    @task = Task.new
    @subteams = Subteam.all
    @teams = Team.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.author_id = current_user.id
    if @task.save
      unless params[:task][:pictures].nil?
        params[:task][:pictures].each do |picture|
          PictureAttachment.create({avatar: picture, imageable: @task})
        end
      end
      flash[:success] = "Task created"
      redirect_to @task
    else
      render 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
    redirect_to root_url unless user_author(@task.author)
    @subteams = Subteam.all
    @teams = Team.all
  end

  def update
    @task = Task.find(params[:id])
    redirect_to root_url unless user_author(@task.author)
    if @task.update_attributes(task_params)
      flash[:success] = "Task updated"
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destory
    Task.find(params[:id]).destroy
    redirect_to tasks_url
  end

  private

    def task_params
      params.require(:task).permit(:title, :content, :team_id, :subteam_id, :pictures)
    end
end
