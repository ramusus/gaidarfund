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
    if not self.position
      self.position = 0
    end
    if not self.color
      self.color = '#FFFFFF'
    end
    super(args)
  end

  rails_admin do
    list do
      include_fields :title, :hide, :position
    end
    edit do
      include_fields :title, :hide, :color, :background_color, :link, :position, :top_text, :background_image
      include_fields :content do
        ckeditor true
        ckeditor_config_js '/javascripts/ckeditor/config.js'
      end
      field :color_class, :enum do
        enum_method do
          :color_class_enum
        end
      end
    end
  end

end