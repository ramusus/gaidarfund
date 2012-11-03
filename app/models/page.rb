class Page < ActiveRecord::Base
  default_scope :order => 'position DESC'
  attr_accessible :title, :slug, :content, :service, :info, :project_id, :page_id, :position

  belongs_to :project
  belongs_to :page
  has_many :pages

  def save(args={})
    if not self.position
      self.position = 0
    end
    super(args)
  end

  def has_project_header
    # TODO: move to template helper
    self.project and not self.project.hide
  end

  def color_class
    # TODO: move to template helper
    self.slug.include?('gaidar') ? 'gaidar' : 'about'
  end

end