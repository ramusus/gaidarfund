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
    NEWS_ID =>        ['news',        '/news/',       'Новости',                          'news'],
    MEMORY_ID =>      ['memories',    '/memories/',   'Воспоминания о Егоре Гайдаре',     'gaidar'],
    MEDIA_ID =>       ['media',       '/media/',      'СМИ о Фонде',                      'about'],
    ANNOUNCE_ID =>    ['announces',   '/calendar/',   'Календарь',    ''],
    INTERVIEW_ID =>   ['interviews',  '/interviews/', 'Интервью',     ''],
    DISCUSSION_ID =>  ['discussions', '/discussions/','Дискуссии',    ''],
    REPORT_ID =>      ['reports',     '/reports/',    'Отчеты',       ''],
    VIDEO_ID =>       ['videos',      '/videos/',     'Видео',        ''],
  }

  PAGES = {
    MEMORY_ID => 'about_gaidar',
    MEDIA_ID => 'about_fund',
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

  def page
    Page.find_by_slug(PAGES[self.id])
  end

end