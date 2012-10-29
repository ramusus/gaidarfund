class Slide < ActiveRecord::Base
  scope :visible, where(:hide => false)
  default_scope :order => 'position DESC'
  attr_accessible :title, :hide, :content, :color, :background_color, :link, :position, :top_text, :background_image

  has_attached_file :background_image, :styles => {:slide => "699x327"}

  def save(args={})
    if not self.color
      self.color = '#FFFFFF'
    end
    super(args)
  end
end