class WeeklyAwardsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  def new
    @weekly_award = WeeklyAward.new
  end

  
end
