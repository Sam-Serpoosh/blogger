class AddPaperclipToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :image_file_name, :string
    add_column :attachments, :image_content_type, :string
    add_column :attachments, :image_file_size, :integer
    add_column :attachments, :image_updated_at, :datetime
  end
end
