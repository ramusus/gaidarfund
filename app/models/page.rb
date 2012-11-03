class Page < ActiveRecord::Base
  default_scope :order => 'position DESC'
  attr_accessible :title, :slug, :content, :service, :info, :project_id, :page_id, :position

  belongs_to :project
  belongs_to :page
  has_many :pages

  def has_project_header
    self.project and not self.project.hide
  end

  def color_class
    self.slug.include?('gaidar') ? 'gaidar' : 'about'
  end

end