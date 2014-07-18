class Update < ActiveRecord::Base

  #updates table

  #id - integer
  #title - string
  #content - text
  #author_id - integer
  #subteam_id - integer
  #team_id - integer
  #created_at - datetime
  #updated_at - datetime

  belongs_to :author, class_name: "User"
  belongs_to :subteam
  belongs_to :team
  has_many :pictures, foreign_key: "parent_id", class_name: 'PictureAttachment', dependent: :destroy

  
  
end