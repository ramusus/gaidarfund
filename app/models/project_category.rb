class ProjectCategory < ActiveRecord::Base
  attr_accessible :name, :project_ids
  has_and_belongs_to_many :projects
end