class AddTeamleadTeamToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :teamlead_team, :integer
  end
end
