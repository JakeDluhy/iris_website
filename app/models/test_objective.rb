class TestObjective < ActiveRecord::Base

  belongs_to :test
  has_many :test_comments
  has_many :test_assignments
  has_many :users, :through => :test_assignments
  belongs_to :user
  has_many :pictures, :class_name => "PictureAttachment", :as => :imageable, dependent: :destroy
  has_many :videos, :class_name => "VideoAttachment", :as => :video, dependent: :destroy

  # after_save :update_date

  # def update_date
  # 	if self.status_change[0] == 'incomplete' and self.status_change[1] == 'completed'
  # 		self.update_attributes({:completed_date => Date.today})
  # 	elsif self.status_change[1] == 'incomplete' and self.status_change[0] == 'completed'
  # 		self.update_attributes({:completed_date => nil})
  # 	end
  # end

  def completer
    user = User.find(self.completer_id) unless self.completer_id.nil?
  end
end