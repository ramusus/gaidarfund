class Project < ActiveRecord::Base

  scope :visible, where(:hide => false)
  default_scope :order => 'position DESC'
  attr_accessible :title, :title_short, :subdomain, :url, :color, :core, :sign, :hide, :about_title, :news_title, :status, :likes, :partners, :counters, :right_block, :projects, :css, :background_image, :logo_image, :html_block, :logo_small_image, :title_seo, :delete_css, :delete_background_image, :delete_logo_image, :delete_logo_small_image, :position

  has_many :articles
  has_many :pages

  has_attached_file :css
  has_attached_file :background_image
  has_attached_file :logo_image
  has_attached_file :logo_small_image, :styles => {:thumb => "220x111"}
  attr_accessor :delete_css
  attr_accessor :delete_background_image
  attr_accessor :delete_logo_image
  attr_accessor :delete_logo_small_image
  before_validation { self.css = nil if self.delete_css == '1' }
  before_validation { self.background_image = nil if self.delete_background_image == '1' }
  before_validation { self.logo_image = nil if self.delete_logo_image == '1' }
  before_validation { self.logo_small_image = nil if self.delete_logo_small_image == '1' }

  def to_s
    self.title_short or self.title
  end

  def body_class
    'award'
  end
end