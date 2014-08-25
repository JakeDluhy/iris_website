class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :team_id
      t.integer :subteam_id
      t.integer :user_id

      t.timestamps
    end
    add_index :memberships, :team_id
    add_index :memberships, :user_id
    add_index :memberships, :subteam_id
    add_index :memberships, [:user_id, :subteam_id], unique: true
  end
end
