class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.integer :user_id
      t.integer :task_id

      t.timestamps
    end
    add_index :workers, :user_id
    add_index :workers, :task_id
    add_index :workers, [:user_id, :task_id], unique: true
  end
end
