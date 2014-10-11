class Api::TutorialsController < Api::ApiController
  def index
    filter = params[:filter].blank? ? 'none' : params[:filter]
    if current_user.nil?
      @tutorials = Tutorial.all.order('updated_at DESC')
    else
      if filter == 'all'
        @tutorials = Tutorial.all.order('updated_at DESC')
      elsif filter == 'gen'
        @tutorials = Tutorial.where('subteam_id IS NULL AND team_id IS NULL').order('updated_at DESC')
      elsif filter == 'team'
        teams = current_user.teams.pluck(:id)
        @tutorials = Tutorial.where('team_id IN (?)', teams).order('updated_at DESC')
      elsif filter == 'sub'
        subteams = current_user.subteams.pluck(:id)
        @tutorials = Tutorial.where('subteam_id IN (?)', subteams).order('updated_at DESC')
      else
        @tutorials = Tutorial.all.order('updated_at DESC')
      end
    end
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    render :json => @tutorial.to_json
  end
end
