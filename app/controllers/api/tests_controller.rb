class Api::TestsController < Api::ApiController
  def index
    filter = params[:filter].blank? ? 'none' : params[:filter]
    if current_user.nil?
      @tests = Test.all.order('updated_at DESC')
    else
      if filter == 'all'
        @tests = Test.all.order('updated_at DESC')
      elsif filter == 'gen'
        @tests = Test.where('subteam_id IS NULL AND team_id IS NULL').order('updated_at DESC')
      elsif filter == 'team'
        teams = current_user.teams.pluck(:id)
        @tests = Test.where('team_id IN (?)', teams).order('updated_at DESC')
      elsif filter == 'sub'
        subteams = current_user.subteams.pluck(:id)
        @tests = Test.where('subteam_id IN (?)', subteams).order('updated_at DESC')
      else
        @tests = Test.all.order('updated_at DESC')
      end
    end
  end

  def show
    @test = Test.find(params[:id])
    render :json => @test.to_json
  end
end
