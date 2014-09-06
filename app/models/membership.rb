require './lib/mailchimp.rb'
class Membership < ActiveRecord::Base

  #memberships table

  #id - integer
  #user_id - integer
  #subteam_id - integer
  #team_id - integer
  #created_at - datetime
  #updated_at - datetime

  belongs_to :user
  belongs_to :subteam
  belongs_to :team
  
  after_create :subscribe_member_to_segment
  before_destroy :unsubscribe_member_from_segment
  after_rollback :unsubscribe_member_from_segment

  #Callbacks
  def subscribe_member_to_segment
    mailchimp = Mailchimp.new
    begin
      mailchimp.subscribe_member_to_segment(team.segment_id, user.email) unless team_id.nil?
    rescue Gibbon::MailChimpError => e
      puts e
    end
    begin
      mailchimp.subscribe_member_to_segment(subteam.segment_id, user.email) unless subteam_id.nil?    
    rescue Gibbon::MailChimpError => e
      puts e
    end
  end

  def unsubscribe_member_from_segment
    mailchimp = Mailchimp.new
    begin
      mailchimp.unsubscribe_member_from_segment(team.segment_id, user.email) unless team_id.nil?
    rescue Gibbon::MailChimpError => e
      puts e
    end
    begin
      mailchimp.unsubscribe_member_from_segment(subteam.segment_id, user.email) unless subteam_id.nil?     
    rescue Gibbon::MailChimpError => e
      puts e
    end  
  end
end