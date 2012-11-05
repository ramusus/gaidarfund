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

  CLASSES = {
    PUBLICATION_ID => 'article',
    NEWS_ID => 'news',
    ANNOUNCE_ID => 'news',
    MEMORY_ID => 'gaidar',
    MEDIA_ID => 'about',
  }

  ROUTES_MAP = {
    # id => code of path method, url, title of page, menu_class in main menu
    NEWS_ID =>        ['news',        '/news/',       'Новости',      'news'],
    ANNOUNCE_ID =>    ['announces',   '/calendar/',   'Анонсы',       'about'],
    MEMORY_ID =>      ['mdia',        '/media/',      'Мемуары',      'gaidar'],
    MEDIA_ID =>       ['memories',    '/memories/',   'СМИ о Фонде',  'about'],
    INTERVIEW_ID =>   ['interviews',  '/interviews/', 'Интервью',     'articles'],
    DISCUSSION_ID =>  ['discussions', '/discussions/','Дискуссии',    'articles'],
    REPORT_ID =>      ['reports',     '/reports/',    'Отчеты',       'articles'],
    VIDEO_ID =>       ['videos',      '/videos/',     'Видео',        'articles'],
  }

  scope :publication, where(:id => PUBLICATION_ID)
  scope :news, where(:id => NEWS_ID)
  scope :media, where(:id => MEDIA_ID)
  scope :memory, where(:id => MEMORY_ID)
  scope :announce, where(:id => ANNOUNCE_ID)

  scope :not_media, where('id != ?', MEDIA_ID)
  scope :not_memory, where('id != ?', MEMORY_ID)
  scope :not_announce, where('id != ?', ANNOUNCE_ID)
  scope :not_news, where('id != ?', NEWS_ID)

  attr_accessible :name, :name_plural

  def color_class
    CLASSES[self.id] or 'article'
  end
end