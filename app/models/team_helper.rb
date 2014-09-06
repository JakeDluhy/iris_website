require './lib/mailchimp.rb'
module TeamHelper
  extend ActiveSupport::Concern

  included do 
    has_many :memberships
    has_many :users, through: :memberships
    has_many :updates
    has_many :tutorials
    has_many :tasks

    after_create :create_email_segment
    before_destroy :delete_email_segment
    after_rollback :delete_email_segment
  end

  #Callbacks
  def create_email_segment
    mailchimp = Mailchimp.new
    begin
      segment_id = mailchimp.create_segment(self.name)
      self.update_attributes(segment_id: segment_id)
    rescue Gibbon::MailChimpError => e
      puts e
    end
  end

  def delete_email_segment
    mailchimp = Mailchimp.new
    begin
      mailchimp.delete_segment(self.segment_id)
    rescue
      puts e
    end
  end
end
