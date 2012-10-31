class Slide < ActiveRecord::Base
  scope :visible, where(:hide => false)
  default_scope :order => 'position DESC'
  attr_accessible :title, :hide, :content, :color, :background_color, :color_class, :link, :position, :top_text, :background_image

  has_attached_file :background_image, :styles => {:slide => "699x327"}

  COLOR_CLASS_OPTIONS = ['news','about','gaidar','article','project'].map{|i| [i,i]}
  validates_inclusion_of :color_class, :in => COLOR_CLASS_OPTIONS.collect{|pair| pair[1]}

  def color_class_enum
    COLOR_CLASS_OPTIONS
  end

  def save(args={})
    if not self.color
      self.color = '#FFFFFF'
    end
    super(args)
  end
end