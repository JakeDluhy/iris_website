class CreateTestObjectives < ActiveRecord::Migration
  def change
    create_table :test_objectives do |t|
    	t.belongs_to :test, index: true
    	t.string :objective
    	t.string :expected_result
    	t.string :result
    	t.string :status
    	t.date :completed_date

    	t.timestamps
    end
  end
end
