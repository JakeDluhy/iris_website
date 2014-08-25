class CreatePictureAttachments < ActiveRecord::Migration
  def change
    create_table :picture_attachments do |t|
      t.string :avatar
      t.references :imageable, polymorphic: true

      t.timestamps
    end
  end
end
