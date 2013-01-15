class ProjectArchivePeriod < ActiveRecord::Base
  default_scope :order => 'date_start DESC'
  attr_accessible :id, :name, :date_start, :date_end, :project_id

  belongs_to :project
end