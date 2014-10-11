class Api::UpdatesController < Api::ApiController
  def index
    filter = params[:filter].blank? ? 'none' : params[:filter]
    if current_user.nil?
      @updates = Update.all.order('updated_at DESC')
    else
      if filter == 'all'
        @updates = Update.all.order('updated_at DESC')
      elsif filter == 'gen'
        @updates = Update.where('subteam_id IS NULL AND team_id IS NULL').order('updated_at DESC')
      elsif filter == 'team'
        teams = current_user.teams.pluck(:id)
        @updates = Update.where('team_id IN (?)', teams).order('updated_at DESC')
      elsif filter == 'sub'
        subteams = current_user.subteams.pluck(:id)
        @updates = Update.where('subteam_id IN (?)', subteams).order('updated_at DESC')
      else
        @updates = Update.all.order('updated_at DESC')
      end
    end
  end

  def show
    @update = Update.find(params[:id])
    render :json => @update.to_json
  end
end
