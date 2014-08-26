class Api::TutorialsController < Api::ApiController
  def index
    filter = params[:filter].blank? ? 'none' : params[:filter]
    if current_user.nil?
      @tutorials = Tutorial.all.order(:updated_at)
    else
      if filter == 'team'
        teams = current_user.teams.pluck(:id)
        @tutorials = Tutorial.where('team_id IN (?)', teams).order(:updated_at)
      elsif filter == 'subteam'
        subteams = current_user.subteams.pluck(:id)
        @tutorials = Tutorial.where('subteam_id IN (?)', subteams).order(:updated_at)
      elsif filter == 'important'
        @tutorials = Tutorial.all.order(:updated_at)
      else
        @tutorials = Tutorial.all.order(:updated_at)
      end
    end
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    render :json => @tutorial.to_json
  end
end