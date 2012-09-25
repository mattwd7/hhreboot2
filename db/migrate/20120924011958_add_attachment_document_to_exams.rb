class AddAttachmentDocumentToExams < ActiveRecord::Migration
  def self.up
    add_column :exams, :document_file_name, :string
    add_column :exams, :document_content_type, :string
    add_column :exams, :document_file_size, :integer
    add_column :exams, :document_updated_at, :datetime
  end

  def self.down
    remove_column :exams, :document_file_name
    remove_column :exams, :document_content_type
    remove_column :exams, :document_file_size
    remove_column :exams, :document_updated_at
  end
end
