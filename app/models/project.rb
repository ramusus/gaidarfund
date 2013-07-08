# -*- coding: utf-8 -*-
class Project < ActiveRecord::Base

  scope :visible, where(:hide => false)
  scope :hidden, where(:hide => true)
  scope :linkable, where(:not_linkable => false)
  default_scope :order => 'position DESC'
  attr_accessible :title, :title_short, :title_list_short, :title_seo, :subdomain, :url, :color, :core, :sign,
    :hide, :hide_sidebar, :hide_news_list, :about_title, :news_title,
    :status, :likes, :partners, :counters, :right_block, :projects, :html_block, :html_block_2, :html_block_3,
    :position, :per_page, :not_linkable,
    :css_styles, :css, :background_image, :logo_image, :logo_small_image, :social_image,
    :delete_css, :delete_background_image, :delete_logo_image, :delete_logo_small_image, :delete_social_image,
    :archive_periods_title, :project_archive_periods,
    :widget_media_articles_count, :widget_media_position,
    :robots_txt

  has_many :articles
  has_many :pages
  has_many :project_archive_periods, :dependent => :destroy, :inverse_of => :project
  has_and_belongs_to_many :project_categories

  accepts_nested_attributes_for :project_archive_periods, :allow_destroy => true
  attr_accessible :project_archive_periods_attributes, :allow_destroy => true

  has_attached_file :css
  has_attached_file :background_image
  has_attached_file :logo_image
  has_attached_file :logo_small_image, :styles => {:thumb => "220>"}
  has_attached_file :social_image, :styles => {:square => "200x200"}
  attr_accessor :delete_css
  attr_accessor :delete_background_image
  attr_accessor :delete_logo_image
  attr_accessor :delete_logo_small_image
  attr_accessor :delete_social_image
  before_validation { self.css = nil if self.delete_css == '1' }
  before_validation { self.background_image = nil if self.delete_background_image == '1' }
  before_validation { self.logo_image = nil if self.delete_logo_image == '1' }
  before_validation { self.logo_small_image = nil if self.delete_logo_small_image == '1' }
  before_validation { self.social_image = nil if self.delete_social_image == '1' }

  def to_s
    self.title_short.blank? ? self.title : self.title_short
  end

  def save(args={})
    if not self.position
      self.position = 0
    end
    if not self.per_page
      self.per_page = 15
    end
    super(args)
  end

  def body_class
    # TODO: move to template helper
    self.subdomain
  end

  def is_lectures?
    self.subdomain == 'lectures'
  end
  def is_club?
    self.subdomain == 'club'
  end
  def events_active
    Article.unscoped.announces.where("project_id = ? AND published_at > ?", self.id, Time.now).order("published_at ASC")
  end

  rails_admin do
    list do
      include_fields :title, :subdomain, :hide, :hide_sidebar, :position
      sort_by :position
      field :position do
        sort_reverse true
      end
    end
    edit do
      include_fields :title do
        help 'Заголовок проекта на странице проекта'
      end
      include_fields :title_short do
        help 'Короткий заголовок проекта в листингах и меню'
      end
      include_fields :title_list_short do
        help 'Краткое название проекта специально для листинга проектов'
      end
      include_fields :position do
        help ''
      end
      include_fields :hide_sidebar do
        help 'Скрыть проект в левом меню проекта'
      end
      include_fields :hide do
        help 'Скрыть проект в автоматических листингах проекта'
      end
      include_fields :hide_news_list do
        help 'Не отображать ленту новостей в листинге проектов'
      end
      include_fields :subdomain do
        help 'Заполняется Если проекту дается поддомен в зоне gaidarfund.ru (надо добавить соответствующий домен в редакторе DNS)'
      end
      include_fields :url do
        help 'Заполняется только если это внешний проект, со своим доменом'
      end
      include_fields :color do
        help ''
      end
      include_fields :sign do
        help ''
      end
      include_fields :status do
        help 'Краткое описание текущего состояния проекта, выводится в листинге проектов и на странице проекта в шапке'
      end
      include_fields :core do
        help 'Краткая суть проекта для листинга (поставить перед статусом)'
      end
#      include_fields :not_linkable do
#        help 'Скрыть проект в выпадающих списка форм материалов и страниц'
#      end
      include_fields :per_page do
        help 'Количество материлов, подгружаемых на странице проекта'
      end

      group :typical_config do
        label "Конфигурация типовых проектов"
        active false
        field :title_seo do
          help 'Шаблон сео-заголовка, к которому добавляется название публикации или страницы (по умолчанию название проекта)'
        end
        field :likes do
          help 'HEAD часть лайков'
        end
        field :projects do
          help 'Содержимое левого блока со смежными проектами под меню "о проекте"'
        end
        field :right_block do
          help 'Содержимое блока справа от ленты'
        end
        field :html_block do
          help 'Произвольный блок, выводится в шапке на всех страницах проекта перед лентой (может содержать, например, краткое описание проекта или баннер)'
        end
        field :html_block_2 do
          help 'Произвольный блок, выводится перед лентой на главной проекта'
          ckeditor true
          ckeditor_config_js '/javascripts/ckeditor/config.js'
        end
        field :html_block_3 do
          help 'Произвольный блок, выводится после лентой на главной проекта'
          ckeditor true
          ckeditor_config_js '/javascripts/ckeditor/config.js'
        end
        field :partners do
          help 'Нижний блок партнеров перед подвалом'
        end
        field :counters do
          help 'Коды счетчиков только для подпроекта (по умолчанию добавляется общий счетчик)'
        end
        field :robots_txt do
          help 'Файл robots.txt для субдомена проекта'
        end
      end

      group :text do
        label "Оформление типового проекта"
        active false
        field :about_title do
          help 'Заголовок блока с меню "о проекте" (по умолчанию "о проекте")'
        end
        field :news_title do
          help 'Заголовок блока с фильтром ленты (если задан для проекта)'
        end
        field :css_styles do
          help 'Cтили для подпроекта (любые правила переопределяются с использование класса с поддоменом проекта для BODY)'
        end
        field :css do
          help 'Таблица стилей для подпроекта (любые правила переопределяются с использование класса с поддоменом проекта для BODY)'
        end
        field :background_image do
          help 'Фоновое изображение (размер не меняется)'
        end
        field :logo_image do
          help 'Картинка для использования в заголовке проекта, если не задается название выводится обычным заголовком (размер не меняется)'
        end
        field :logo_small_image do
          help 'Картинка для использования в листинге проектов (уменьшается по ширине под размер колонки)'
        end
        field :social_image do
          help 'Картинка проекта используемая в социальных сетях (уменьшается до размера 89 на 89 пикс)'
        end
      end

      group :widget_media do
        label "Виджет СМИ"
        active false
        field :widget_media_articles_count do
          help 'Оставьте поле пустым или равным 0, если хотите скрыть виджет'
        end
        field :widget_media_position do
          help 'Позиция виджета среди анонсов материалов, возможно любое число >= 2'
        end
      end

      group :archive do
        label "Циклы архива"
        active false
        field :archive_periods_title
        field :project_archive_periods
      end
    end
  end

end