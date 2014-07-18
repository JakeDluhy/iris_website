class PictureAttachment < ActiveRecord::Base
  #picture_attachments table

  #id - integer
  #avatar - string
  #parent_id - integer
  #created_at - datetime
  #updated_at - datetime

  belongs_to :updated
  belongs_to :instruction
  belongs_to :task

  mount_uploader :avatar, AvatarUploader
end
