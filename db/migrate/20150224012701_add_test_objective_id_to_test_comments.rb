class AddTestObjectiveIdToTestComments < ActiveRecord::Migration
  def change
  	add_column :test_comments, :test_objective_id, :integer
  end
end
