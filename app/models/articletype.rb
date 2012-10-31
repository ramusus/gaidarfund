class Articletype < ActiveRecord::Base

  ANNOUNCE_ID = 7
  NEWS_ID = 4
  PUBLICATION_ID = 1

  CLASSES = {
    PUBLICATION_ID => 'article',
    NEWS_ID => 'news',
    ANNOUNCE_ID => 'news',
  }

  scope :publications, where(:id => PUBLICATION_ID)
  scope :news, where(:id => NEWS_ID)
  scope :announce, where(:id => ANNOUNCE_ID)
  scope :not_announce, where('id != ?', ANNOUNCE_ID)
  scope :not_news, where('id != ?', NEWS_ID)

  attr_accessible :name, :name_plural

  def color_class
    CLASSES[self.id] or 'article'
  end
end