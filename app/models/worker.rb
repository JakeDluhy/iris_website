class Worker < ActiveRecord::Base

  #workers table

  #id - integer
  #user_id - integer [index]
  #task_id - integer [index]
  #created_at - datetime
  #updated_at - datetime

  belongs_to :user
  belongs_to :task
end
