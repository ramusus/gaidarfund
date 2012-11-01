class Page < ActiveRecord::Base
  default_scope :order => 'position DESC'
  attr_accessible :title, :slug, :content, :service, :info, :project_id, :page_id, :position

  belongs_to :project
  belongs_to :page
  has_many :pages

end