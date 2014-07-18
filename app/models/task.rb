class Task < ActiveRecord::Base

  #tasks table

  #id - integer
  #title - string
  #content - text
  #authod_id - integer
  #subteam_id - integer
  #created_at - datetime
  #updated_at - datetime
  
  belongs_to :author, class_name: "User"
  belongs_to :subteam
  has_many :workers
  has_many :users, through: :workers
  has_many :pictures, foreign_key: "parent_id", class_name: 'PictureAttachment' dependent: :destroy
end
