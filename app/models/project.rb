class Project < ActiveRecord::Base
  attr_accessible :title, :subdomain, :color, :sign, :about_title, :news_title, :status, :likes, :partners, :counters, :right_block, :projects, :background_image, :logo_image

  has_many :news
  has_many :events

  has_attached_file :background_image
  has_attached_file :logo_image
end