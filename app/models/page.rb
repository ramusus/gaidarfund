class Page < ActiveRecord::Base
  attr_accessible :title, :slug, :content, :service, :info, :project_id

  belongs_to :project
end