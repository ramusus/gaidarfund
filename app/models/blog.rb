class Blog < ActiveRecord::Base
  attr_accessible :author, :photo, :link, :description

  has_attached_file :photo, :styles => {:square => "70x70"}
end
