class AddMemberOfTheWeekToUsers < ActiveRecord::Migration
  def change
    add_column :users, :member_of_the_week, :boolean, :default => false
  end
end
