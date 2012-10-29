class Project < ActiveRecord::Base
  attr_accessible :title, :title_short, :subdomain, :color, :sign, :about_title, :news_title, :status, :likes, :partners, :counters, :right_block, :projects, :background_image, :logo_image, :html_block

  has_many :articles

  has_attached_file :background_image
  has_attached_file :logo_image

  def to_s
    self.title_short or self.title
  end
end