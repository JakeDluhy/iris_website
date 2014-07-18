class CreateSubteams < ActiveRecord::Migration
  def change
    create_table :subteams do |t|
      t.string :name
      t.string :description
      t.string :hook
      t.integer :team_id
      t.integer :segment_id
    end
  end
end
