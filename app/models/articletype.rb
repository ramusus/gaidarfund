# -*- coding: utf-8 -*-
class Articletype < ActiveRecord::Base

  PUBLICATION_ID = 1
  INTERVIEW_ID = 2
  DISCUSSION_ID = 3
  NEWS_ID = 4
  REPORT_ID = 5
  VIDEO_ID = 6
  ANNOUNCE_ID = 7
  MEDIA_ID = 8
  MEMORY_ID = 9
  BOOK_ID = 10

  scope :publication, where(:id => PUBLICATION_ID)
  scope :news, where(:id => NEWS_ID)
  scope :media, where(:id => MEDIA_ID)
  scope :memory, where(:id => MEMORY_ID)
  scope :announce, where(:id => ANNOUNCE_ID)

  scope :not_media, where('id != ?', MEDIA_ID)
  scope :not_memory, where('id != ?', MEMORY_ID)
  scope :not_announce, where('id != ?', ANNOUNCE_ID)
  scope :not_news, where('id != ?', NEWS_ID)
  scope :not_book, where('id != ?', BOOK_ID)

  attr_accessible :name, :name_plural, :slug, :code, :title, :color_class, :page_id, :filter_hide

  COLOR_CLASS_OPTIONS = ['','news','about','gaidar','article','project'].map{|i| [i,i]}
  validates_inclusion_of :color_class, :in => COLOR_CLASS_OPTIONS.collect{|pair| pair[1]}

  belongs_to :page

  def color_class_enum
    COLOR_CLASS_OPTIONS
  end

end