class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.string :title
      t.integer :author_id
      t.integer :team_id
      t.integer :subteam_id

      t.timestamps
    end
  end
end
