class AddTeamIdToTests < ActiveRecord::Migration
  def change
  	add_column :tests, :team_id, :integer
  	add_column :test_objectives, :completer_id, :integer
  end
end
