class CreateFileDownloads < ActiveRecord::Migration[4.2]
  def change
    create_table :file_downloads do |t|
      t.string :file_id
      t.string :label
      t.string :checksum
      t.string :filetype
      t.string :virus_id
      t.string :file_filename
      t.string :user_id
      t.string :file_content_type

      t.timestamps null: false
    end
  end
end
