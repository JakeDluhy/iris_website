class CreateTestAssignments < ActiveRecord::Migration
  def change
    create_table :test_assignments do |t|
    	t.belongs_to :test_objective, index: true
    	t.belongs_to :user, index: true

    	t.timestamps
    end
  end
end
