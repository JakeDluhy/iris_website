class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :description
      t.string :hook
      t.integer :segment_id

      t.timestamps
    end
  end
end
