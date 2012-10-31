class Project < ActiveRecord::Base
  attr_accessible :title, :title_short, :subdomain, :color, :core, :sign, :about_title, :news_title, :status, :likes, :partners, :counters, :right_block, :projects, :css, :background_image, :logo_image, :html_block, :logo_small_image, :title_seo

  has_many :articles
  has_many :pages

  has_attached_file :css
  has_attached_file :background_image
  has_attached_file :logo_image
  has_attached_file :logo_small_image, :styles => {:thumb => "220x111"}

  def to_s
    self.title_short or self.title
  end

  def body_class
    'award'
  end
end