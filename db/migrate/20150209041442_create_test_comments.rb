class CreateTestComments < ActiveRecord::Migration
  def change
    create_table :test_comments do |t|
    	t.string :comment
    	t.belongs_to :user, index: true

    	t.timestamps
    end
  end
end
