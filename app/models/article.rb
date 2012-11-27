class Article < ActiveRecord::Base

  scope :not_announces, where("articletype_id != ?", Articletype::ANNOUNCE_ID)
  scope :not_news, where("articletype_id != ?", Articletype::NEWS_ID)

  scope :announces, where(:articletype_id => Articletype::ANNOUNCE_ID)
  scope :news, where(:articletype_id => Articletype::NEWS_ID)
  scope :publications, where(:articletype_id => Articletype::PUBLICATION_ID)

  scope :main, where(:main => true)
  scope :main_for_project, where(:main_for_project => true)
  scope :visible, where(:hide => false).where(:only_for_signed => false)

  default_scope :order => 'published_at DESC, id DESC'
  attr_accessible :title, :subtitle, :image, :url, :main, :main_for_project, :hide, :hide_discussions, :content, :checked, :only_for_signed,
    :old_id, :published_at, :title_seo, :right_column, :project_id, :articletype_id, :delete_image, :old_group_id,
    :old_descr, :old_descr2, :author,
    :social_image, :delete_social_image

  has_attached_file :image, :styles => {:square => "140x140"}
  has_attached_file :social_image, :styles => {:square => "200x200"}
  attr_accessor :delete_image
  attr_accessor :delete_social_image
  before_validation { self.image = nil if self.delete_image == '1' }
  before_validation { self.social_image = nil if self.delete_social_image == '1' }

  belongs_to :project
  belongs_to :articletype

# http://stackoverflow.com/questions/3396831/rails-many-to-many-self-join
#  has_many :related1, :foreign_key => "article_id", :class_name => "Relation"
#  has_many :related, :through => :relations

  define_index do
#    indexes published_at, :sortable => true
    indexes title
    indexes subtitle
    indexes content
    indexes author

    # attributes
    has project_id, articletype_id, published_at, id
  end

  def save(args={})
    if not self.published_at
      self.published_at = Time.now
    end
    if not self.articletype_id
      self.articletype_id = Articletype::PUBLICATION_ID
    end
    super(args)
  end

  def type
    self.articletype
  end

  def color_class
    # TODO: move to template helper
    if self.type.id == Articletype::MEDIA_ID or not self.project
      self.type.color_class
    elsif self.project
      'project'
    else
      ''
    end
  end

  def is_video?
    self.type.id == Articletype::VIDEO_ID
  end
  def is_memory?
    self.type.id == Articletype::MEMORY_ID
  end
  def is_media?
    self.type.id == Articletype::MEDIA_ID
  end
  def is_book?
    self.type.id == Articletype::BOOK_ID
  end
  def is_news?
    self.type.id == Articletype::NEWS_ID
  end

end

#class Relation < ActiveRecord::Base
#   belongs_to :article, :foreign_key => "article_id", :class_name => "Article"
#   belongs_to :related, :foreign_key => "related_id", :class_name => "Article"
#end