class Tutorial < ActiveRecord::Base

  #tutorials table

  #id - integer
  #title - string
  #authod_id - integer
  #subteam_id - integer
  #created_at - datetime
  #updated_at - datetime

  belongs_to :author, class_name: "User"
  belongs_to :team
  belongs_to :subteam
  has_many :instructions, dependent: :destroy
end
