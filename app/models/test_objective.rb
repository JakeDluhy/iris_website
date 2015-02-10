class TestObjective < ActiveRecord::Base

  belongs_to :test
  has_many :test_comments
  has_many :users, :through => :test_assignments
  has_many :pictures, :class_name => "PictureAttachment", :as => :imageable, dependent: :destroy

end