class TestComment < ActiveRecord::Base

  belongs_to :test_objective
  belongs_to :user

end