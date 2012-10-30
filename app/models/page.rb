class Page < ActiveRecord::Base
  attr_accessible :title, :slug, :content, :service, :info, :project_id, :page_id

  belongs_to :project
  belongs_to :page
  has_many :pages

end