class CreateVideoAttachment < ActiveRecord::Migration
  def change
    create_table :video_attachments do |t|
    	t.string :url
      t.references :video, polymorphic: true

      t.timestamps
    end
  end
end
