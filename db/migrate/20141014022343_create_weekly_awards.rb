class CreateWeeklyAwards < ActiveRecord::Migration
  def change
    create_table :weekly_awards do |t|
      t.string :award_type
      t.string :award_description
      t.integer :user_id

      t.timestamps
    end
  end
end
