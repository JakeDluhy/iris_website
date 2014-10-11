class Api::TasksController < Api::ApiController
  def index
    filter = params[:filter].blank? ? 'none' : params[:filter]
    if current_user.nil?
      @tasks = Task.all.order('updated_at DESC')
    else
      if filter == 'all'
        @tasks = Task.all.order('updated_at DESC')
      elsif filter == 'gen'
        @tasks = Task.where('subteam_id IS NULL AND team_id IS NULL').order('updated_at DESC')
      elsif filter == 'team'
        teams = current_user.teams.pluck(:id)
        @tasks = Task.where('team_id IN (?)', teams).order('updated_at DESC')
      elsif filter == 'sub'
        subteams = current_user.subteams.pluck(:id)
        @tasks = Task.where('subteam_id IN (?)', subteams).order('updated_at DESC')
      else
        @tasks = Task.all.order('updated_at DESC')
      end
    end
  end

  def show
    @task = Task.find(params[:id])
    render :json => @task.to_json
  end
end
