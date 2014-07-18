class UpdatesController < ApplicationController


  def index
    @updates = Update.all
  end

  def new
    @update = Update.new
    @teams = Team.all
    @subteams = Subteam.all
  end

  def show
    @update = Update.find(params[:id])
    @pictures = @update.pictures
  end

  def create
    @update = Update.new(update_params)
    @update.author_id = current_user.id
    if @update.save
      unless params[:update][:pictures].nil?
        params[:update][:pictures].each do |picture|
          PictureAttachment.create({avatar: picture, parent_id: @update.id})
        end
      end
      email_to_members(@update)
      flash[:success] = "Update created!"
      redirect_to updates_url
    else
      render 'new'
    end
  end

  def destory
    Update.find(params[:id]).destroy
  end

  def email_to_members(update)
    mailchimp = API::Mailchimp.new
    if !update.team_id.nil?
      team = Team.find(update.team_id)
    elsif !update.subteam_id.nil?
      team = Subteam.find(update.subteam_id)
    else
      team = nil
    end
    team.nil? ? team_name = nil : team_name = team.name
    team.nil? ? team_segment_id = nil  : team_segment_id = team.segment_id
    picture_urls = []
    update.pictures.each do |picture|
      picture_urls << request.protocol + request.host_with_port + picture.avatar.url
    end
    mailchimp.send_out_emails(team_name, team_segment_id, User.find(update.author_id).name, update.title, update.content, picture_urls)
  end

  private

    def update_params
      params.require(:update).permit(:title, :content, :subteam_id, :team_id, :pictures)
    end

end
