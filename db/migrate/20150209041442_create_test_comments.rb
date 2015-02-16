class CreateTestComments < ActiveRecord::Migration
  def change
    create_table :test_comments do |t|
    	t.text :comment
    	t.belongs_to :user, index: true
    	t.belongs_to :test_objective, index: true

    	t.timestamps
    end
  end
end
