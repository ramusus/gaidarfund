class Event < ActiveRecord::Base
  attr_accessible :title, :subtitle, :link, :date, :content, :old_id, :old_group_id, :project_id, :visible
  belongs_to :project
end