class Api::UpdatesController < Api::ApiController
  def index
    filter = params[:filter].blank? ? 'none' : params[:filter]
    if current_user.nil?
      @updates = Update.all.order(:updated_at)
    else
      if filter == 'team'
        teams = current_user.teams.pluck(:id)
        @updates = Update.where('team_id IN (?)', teams).order(:updated_at)
      elsif filter == 'subteam'
        subteams = current_user.subteams.pluck(:id)
        @updates = Update.where('subteam_id IN (?)', subteams).order(:updated_at)
      elsif filter == 'important'
        @updates = Update.all.order(:updated_at)
      else
        @updates = Update.all.order(:updated_at)
      end
    end
  end

  def show
    @update = Update.find(params[:id])
    render :json => @update.to_json
  end
end
