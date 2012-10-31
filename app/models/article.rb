class Article < ActiveRecord::Base

  scope :announces, where(:articletype_id => Articletype::ANNOUNCE_ID)
  scope :news, where(:articletype_id => Articletype::NEWS_ID)
  scope :publications, where(:articletype_id => Articletype::PUBLICATION_ID)

  scope :main, where(:main => true)
  scope :visible, where(:hide => false)

  default_scope :order => 'published_at DESC, id DESC'
  attr_accessible :title, :subtitle, :image, :main, :hide, :hide_discussions, :content, :checked, :old_id, :published_at, :title_seo, :right_column, :project_id, :articletype_id, :delete_image, :old_group_id, :old_descr, :old_descr2, :author

  has_attached_file :image, :styles => {:square => "140x140"}
  attr_accessor :delete_image
  before_validation { self.image = nil if self.delete_image == '1' }

  belongs_to :project
  belongs_to :articletype

  self.per_page = 30

# http://stackoverflow.com/questions/3396831/rails-many-to-many-self-join
#  has_many :related1, :foreign_key => "article_id", :class_name => "Relation"
#  has_many :related, :through => :relations

  def save(args={})
    if not self.published_at
      self.published_at = Time.now
    end
    super(args)
  end

  def type
    self.articletype
  end

  def type_class
    types = {
      1 => 'article',
      4 => 'news',
      7 => 'news',
    }
    type = types[self.type.id]
    type ? type : 'article'
  end

end

#class Relation < ActiveRecord::Base
#   belongs_to :article, :foreign_key => "article_id", :class_name => "Article"
#   belongs_to :related, :foreign_key => "related_id", :class_name => "Article"
#end