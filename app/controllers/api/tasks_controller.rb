class Api::TasksController < Api::ApiController
  def index
    filter = params[:filter].blank? ? 'none' : params[:filter]
    if current_user.nil?
      @tasks = Task.all.order(:updated_at)
    else
      if filter == 'team'
        teams = current_user.teams.pluck(:id)
        @tasks = Task.where('team_id IN (?)', teams).order(:updated_at)
      elsif filter == 'subteam'
        subteams = current_user.subteams.pluck(:id)
        @tasks = Task.where('subteam_id IN (?)', subteams).order(:updated_at)
      elsif filter == 'important'
        @tasks = Task.all.order(:updated_at)
      else
        @tasks = Task.all.order(:updated_at)
      end
    end
  end

  def show
    @task = Task.find(params[:id])
    render :json => @task.to_json
  end
end
