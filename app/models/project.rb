class Project < ActiveRecord::Base

  scope :visible, where(:hide => false)
  scope :linkable, where(:not_linkable => false)
  default_scope :order => 'position DESC'
  attr_accessible :title, :title_short, :title_seo, :subdomain, :url, :color, :core, :sign, :hide, :about_title, :news_title,
    :status, :likes, :partners, :counters, :right_block, :projects, :html_block, :position, :per_page, :not_linkable,
    :css, :background_image, :logo_image, :logo_small_image, :logo_social_image,
    :delete_css, :delete_background_image, :delete_logo_image, :delete_logo_small_image, :delete_logo_social_image

  has_many :articles
  has_many :pages

  has_attached_file :css
  has_attached_file :background_image
  has_attached_file :logo_image
  has_attached_file :logo_small_image, :styles => {:thumb => "220>"}
  has_attached_file :logo_social_image, :styles => {:square => "89x89"}
  attr_accessor :delete_css
  attr_accessor :delete_background_image
  attr_accessor :delete_logo_image
  attr_accessor :delete_logo_small_image
  attr_accessor :delete_logo_social_image
  before_validation { self.css = nil if self.delete_css == '1' }
  before_validation { self.background_image = nil if self.delete_background_image == '1' }
  before_validation { self.logo_image = nil if self.delete_logo_image == '1' }
  before_validation { self.logo_small_image = nil if self.delete_logo_small_image == '1' }
  before_validation { self.logo_social_image = nil if self.delete_logo_social_image == '1' }

  def to_s
    self.title_short.blank? ? self.title : self.title_short
  end

  def save(args={})
    if not self.position
      self.position = 0
    end
    if not self.per_page
      self.per_page = 15
    end
    super(args)
  end

  def body_class
    # TODO: move to template helper
    self.subdomain
  end
end