class Slide < ActiveRecord::Base
  scope :visible, where(:hide => false)
  default_scope :order => 'position DESC'
  attr_accessible :title, :hide, :content, :color, :background_color, :link, :position, :top_text

  def save(args={})
    if not self.color
      self.color = '#FFFFFF'
    end
    super(args)
  end
end