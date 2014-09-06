class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.text :hook
      t.integer :segment_id

      t.timestamps
    end
  end
end
