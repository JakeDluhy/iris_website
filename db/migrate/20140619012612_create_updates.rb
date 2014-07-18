class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :title
      t.text :content
      t.integer :author_id
      t.integer :team_id
      t.integer :subteam_id
      t.integer :team_id
    end
  end
end
