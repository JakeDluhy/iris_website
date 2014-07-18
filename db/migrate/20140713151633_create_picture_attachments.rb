class CreatePictureAttachments < ActiveRecord::Migration
  def change
    create_table :picture_attachments do |t|
      t.integer :parent_id
      t.string :avatar

      t.timestamps
    end
  end
end
