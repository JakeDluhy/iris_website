class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.string :title
      t.string :content
      t.integer :tutorial_id
      t.integer :order_id
    end
  end
end
