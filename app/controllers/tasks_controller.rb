class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @subteams = Subteam.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.author_id = current_user.id
    if @task.save
      flash[:success] = "Task created"
      redirect_to @task
    else
      render 'new'
    end
  end

  def destory
    Task.find(params[:id]).destroy
    redirect_to tasks_url
  end

  private

    def task_params
      params.require(:task).permit(:title, :content, :pictures)
    end
end
