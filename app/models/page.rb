class Page < ActiveRecord::Base
  scope :visible, where(:visible => true)
  default_scope :order => 'position DESC'
  attr_accessible :title, :slug, :content, :service, :info, :project_id, :page_id, :position, :visible

  belongs_to :project
  belongs_to :page
  has_many :pages

  def save(args={})
    if not self.position
      self.position = 0
    end
    super(args)
  end

  def color_class
    # TODO: move to template helper
    (self.slug == 'about_gaidar' || self.page && self.page.slug == 'about_gaidar') ? 'gaidar' : 'about'
  end

end