class Api::UsersController < Api::ApiController
  def index
    filter = params[:filter].blank? ? 'none' : params[:filter]
    if current_user.nil?
      @users = User.all.order(:updated_at)
    else
      if filter == 'team'
        #Work on this - need to fit array of ids in in array of ids
        teams = current_user.teams.pluck(:id)
        @users = User.where('team_id IN (?)', teams).order(:updated_at)
      elsif filter == 'subteam'
        subteams = current_user.subteams.pluck(:id)
        @users = User.where('subteam_id IN (?)', subteams).order(:updated_at)
      elsif filter == 'important'
        @users = User.all.order(:updated_at)
      else
        @users = User.all.order(:updated_at)
      end
    end
  end

  def show
    @user = User.find(params[:id])
    render :json => @user.to_json
  end
end
