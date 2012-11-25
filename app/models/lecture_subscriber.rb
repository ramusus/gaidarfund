class LectureSubscriber < ActiveRecord::Base
  attr_accessible :name, :email, :article_id
  validates :name, :presence => true
  validates :email, :presence => true
  validates :article, :presence => true

  belongs_to :article

  def to_s
    "#{name} (#{email})"
  end
end