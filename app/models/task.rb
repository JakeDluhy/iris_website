class Task < ActiveRecord::Base

  #tasks table

  #id - integer
  #title - string
  #content - text
  #authod_id - integer
  #subteam_id - integer
  #team_id - integer
  #created_at - datetime
  #updated_at - datetime
  
  belongs_to :author, class_name: "User"
  belongs_to :subteam
  belongs_to :team
  has_many :workers
  has_many :users, through: :workers
  has_many :pictures, :class_name => "PictureAttachment", :as => :imageable, dependent: :destroy
end
