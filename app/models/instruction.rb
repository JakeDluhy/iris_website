class Instruction < ActiveRecord::Base

  #intructions table

  #id - integer
  #title - string
  #content - string
  #order_id - integer
  #tutorial_id - integer
  #created_at - datetime
  #updated_at - datetime

  belongs_to :tutorial
  has_many :pictures, :class_name => "PictureAttachment", :as => :imageable, dependent: :destroy
end
