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
    mailchimp = API::Mailchimp.new
    segment_id = mailchimp.create_segment(self.name)
    self.update_attributes(segment_id: segment_id)
  end

  def delete_email_segment
    mailchimp = API::Mailchimp.new
    mailchimp.delete_segment(self.segment_id)
  end
end
