class Exam < ActiveRecord::Base
   	attr_accessible :document, :professor, :term, :quality, :course_id, :user_id, :description
  	attr_accessible :irrelevant_count, :duplicate_count, :misplaced_count, :download_count
  	attr_accessible :document_file_name, :document_content_type, :document_file_size

  	has_attached_file :document

  	belongs_to :user
  	belongs_to :course
    has_many :examrecords

  	validates_attachment :document, :presence => true,
  		:content_type => { :content_type => "application/pdf" },
  		:size => { :in => 0..5.megabytes}
  	validates :course_id, :presence => true
    validates :document_file_name, :uniqueness => true

end