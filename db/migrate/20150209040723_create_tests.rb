class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
    	t.string :name
    	t.belongs_to :subteam
    	t.date :test_date
    	t.integer :robot_version
    	t.integer :test_index

    	t.timestamps
    end
  end
end
