class Team < ActiveRecord::Base
  include TeamHelper

  #teams table

  #id - integer
  #name - string
  #description - string
  #segment_id - integer
  #created_at - datetime
  #updated_at - datetime

  has_many :subteams

  has_one :team_lead, class_name: 'User', foreign_key: 'teamlead_team'

  #Methods
  def add_user_membership(user)
    Membership.create({:team_id => self.id, :user_id => user.id})
  end
end
