class WeeklyAwardsController < ApplicationController

  def new
    @weekly_award = WeeklyAward.new
    @users = User.order('name ASC')
  end

  def create
    @weekly_award = WeeklyAward.new(award_params)
    if @weekly_award.save
      User.where('member_of_the_week IS TRUE').update_all({:member_of_the_week => false})
      User.find(@weekly_award.user_id).update_attributes({:member_of_the_week => true}) unless @weekly_award.user_id.nil?
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def award_params
      params.require(:weekly_award).permit(:award_type, :award_description, :award_week, :user_id)
    end
end
