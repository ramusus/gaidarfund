class Article < ActiveRecord::Base

  scope :not_announces, where("articletype_id != ?", Articletype::ANNOUNCE_ID)
  scope :not_news, where("articletype_id != ?", Articletype::NEWS_ID)

  scope :announces, where(:articletype_id => Articletype::ANNOUNCE_ID)
  scope :news, where(:articletype_id => Articletype::NEWS_ID)
  scope :publications, where(:articletype_id => Articletype::PUBLICATION_ID)

  scope :main, where(:main => true)
  scope :visible, where(:hide => false).where("published_at < ?", Time.now)

  default_scope :order => 'published_at DESC, id DESC'
  attr_accessible :title, :subtitle, :image, :url, :main, :hide, :hide_discussions, :content, :checked,
    :old_id, :published_at, :title_seo, :right_column, :project_id, :articletype_id, :delete_image, :old_group_id,
    :old_descr, :old_descr2, :author

  has_attached_file :image, :styles => {:square => "140x140"}
  attr_accessor :delete_image
  before_validation { self.image = nil if self.delete_image == '1' }

  belongs_to :project
  belongs_to :articletype

# http://stackoverflow.com/questions/3396831/rails-many-to-many-self-join
#  has_many :related1, :foreign_key => "article_id", :class_name => "Relation"
#  has_many :related, :through => :relations

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
    self.project ? 'project' : self.type.color_class
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

end

#class Relation < ActiveRecord::Base
#   belongs_to :article, :foreign_key => "article_id", :class_name => "Article"
#   belongs_to :related, :foreign_key => "related_id", :class_name => "Article"
#end