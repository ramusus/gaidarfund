class Event < ActiveRecord::Base
  default_scope :order => 'date DESC, id DESC'
  attr_accessible :title, :subtitle, :link, :date, :content, :old_id, :old_group_id, :project_id, :visible
  belongs_to :project
end