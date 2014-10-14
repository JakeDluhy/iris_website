class AddAwardWeekToWeeklyAwards < ActiveRecord::Migration
  def change
    add_column :weekly_awards, :award_week, :string
  end
end
