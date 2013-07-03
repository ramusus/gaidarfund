# -*- coding: utf-8 -*-
class Article < ActiveRecord::Base

  scope :not_announces, where("articletype_id != ?", Articletype::ANNOUNCE_ID)
  scope :not_news, where("articletype_id != ?", Articletype::NEWS_ID)
  scope :not_media, where("articletype_id != ?", Articletype::MEDIA_ID)

  scope :announces, where(:articletype_id => Articletype::ANNOUNCE_ID)
  scope :news, where(:articletype_id => Articletype::NEWS_ID)
  scope :publications, where(:articletype_id => Articletype::PUBLICATION_ID)
  scope :media, where(:articletype_id => Articletype::MEDIA_ID)

  scope :main, where(:main => true)
  scope :main_for_project, where(:main_for_project => true)
  scope :visible, where(:hide => false).where(:only_for_signed => false)
  scope :visible_on_index, visible.where(:hide_on_index => false)

  default_scope :order => 'published_at DESC, id DESC'
  attr_accessible :title, :subtitle, :image, :url, :main, :main_for_project, :hide, :hide_discussions, :content, :checked, :only_for_signed,
    :old_id, :published_at, :title_seo, :right_column, :project_id, :articletype_id, :delete_image, :old_group_id, :play_icon, :hide_on_index,
    :old_descr, :old_descr2, :author,
    :social_image, :delete_social_image,
    :featured_block_type

  has_attached_file :image, :styles => {:square => "140x140",
    :featured_vertical => "113x",
    :featured_horizontal => "190x",
    :featured_big => "453x",
  }
  has_attached_file :social_image, :styles => {:square => "200x200"}
  attr_accessor :delete_image
  attr_accessor :delete_social_image
  before_validation { self.image = nil if self.delete_image == '1' }
  before_validation { self.social_image = nil if self.delete_social_image == '1' }

  belongs_to :project
  belongs_to :articletype

  FEATURED_BLOCK_TYPE_OPTIONS = [
    ['без картинки', 1],
    ['с вертикальной картинкой', 2],
    ['с горизонтальной картинкой', 3],
    ['с большой горизонтальной картинкой в компоновке с анонсом на вырубке', 4],
    ['с большой картинкой с заголовком слева', 5],
  ]
  validates_inclusion_of :featured_block_type, :in => FEATURED_BLOCK_TYPE_OPTIONS.collect{|pair| pair[1]}

  def featured_block_type_enum
    FEATURED_BLOCK_TYPE_OPTIONS
  end

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
    if self.type.id == Articletype::MEDIA_ID or not self.project
      self.type.color_class
    elsif self.project
      'project'
    else
      ''
    end
  end

  def color_style
    self.project_color.empty? ? '' : ' style="color: ' + self.project_color + ' !important;"'
  end

  def background_color_style
    self.project_color.empty? ? '' : ' style="background-color: ' + self.project_color + ' !important;"'
  end

  def project_color
    if self.project and self.project.color
      self.project.color
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
  def is_announce?
    self.type.id == Articletype::ANNOUNCE_ID
  end

  rails_admin do
    list do
      include_fields :published_at, :title, :project, :articletype, :main, :hide
    end
    show do
      include_fields :title, :published_at, :subtitle, :project, :main, :checked
      include_fields :content do
        pretty_value do
          value.html_safe
         end
      end
    end
    edit do
      include_fields :title do
        help 'Основной заголовок, желательно не длиннее 100 символов'
      end
      include_fields :subtitle do
        help 'Краткое описание под заголовком, желательно до 200 символов'
      end
      include_fields :image do
        help 'Картинка для листинга материалов (уменьшается по ширине до размера колонки)'
      end
      include_fields :articletype do
        help 'Тип публикации, она же метка на цветной вкладке в листинге материалов'
      end
      include_fields :project do
        help 'Принадлежность материала проекту'
        associated_collection_scope do
          Proc.new { |scope|
            scope = scope.linkable
          }
        end
      end
      include_fields :url do
        help 'Указывается только если необходим переход с анонса на внешний проект (тело материала в таком случае уже не показывается)'
      end
      include_fields :author do
        help 'Если задан, выводится под заголовком'
      end
      include_fields :main do
        help 'Ставиться вверху ленты, в которой представляется материал (показывается вверху один самый свежий материал).'
      end
      include_fields :main_for_project do
        help 'Ставиться вверху ленты проекта, в котором представляется материал (показывается вверху один самый свежий материал).'
      end
      field :featured_block_type, :enum do
        enum_method do
          :featured_block_type_enum
        end
        help 'Тип отображения основного материала вверху ленты'
      end
      include_fields :hide_discussions do
        help 'Скрыть переход на вкладку "Обсуждение"'
      end
      include_fields :checked do
        help 'Метка для редактора'
      end
      include_fields :hide do
        help 'Скрытый материал доступен всем по прямой ссылке, он скрывается только из листингов'
      end
      include_fields :hide_on_index do
        help 'Скрыть из листинга главной страницы'
      end
      include_fields :only_for_signed do
        help 'Материал скрывается из всех листингов и доступен по прямой ссылке только авторизованным'
      end
      include_fields :play_icon do
        help 'Добавить иконку play на картинку анонса материала'
      end
      include_fields :published_at do
      end
      include_fields :title_seo do
        help 'Сео заголовок (если пуст, то по умолчанию выводистя title материала)'
      end
      include_fields :content do
        help do
          value = 'Основной блок материала.

          Табы:
          <div id="article-tabs">
          <div class="article-tab" title="Вкладка 1"></div>
          <div class="article-tab" title="Вкладка 2"></div>
          </div>

          Для персон:
          <ul class="b-persons">
          <li class="item">
          <h3 class="title"><img alt="Кирилл Рогов" class="image" src="/system/pictures/215/content_rogov.jpg" width="120" /> Кирилл Рогов</h3>
          <p class="desc">Должность и краткое представление или текст от имени персоны</p>
          </li>
          </ul>

          Для подзаголовков и акцентированных абзацев:
          <h2 class="b-page-title">Крупный подзаголовок</h2>
          <h3 class="b-sub-title">Подзаголовок цвета раздела</h3>
          <p class="b-sub-intro"><strong>Заглавный абзац в блоке, ставиться </strong></p>
          <p class="b-huge-intro">Заглавный абзац, цвета раздела с отступом слева</p>

          Для цитат:
          <blockquote><p>Текст цитаты серым крупным, не жирным</p></blockquote>
          <blockquote class="b-compact-quote"><p>Цитата жирным компактным шрифтом</p></blockquote>

          Раскрывающийся блок:
          <div class="article-desc" title="Описание" hide-title="Скрыть описание">Описание</div>
          '
          value.gsub(/</,"&lt;").gsub(/>/,"&gt;").gsub(/\n/,"<br />").html_safe
        end
      end
      include_fields :right_column do
        help 'Выводится под списком смежных материалов "Еще по теме"'
      end
      include_fields :social_image do
        help 'Картинка проекта используемая в социальных сетях (уменьшается до размера 89 на 89 пикс)'
      end
      include_fields :content, :right_column do
        ckeditor true
        ckeditor_config_js '/javascripts/ckeditor/config.js'
      end
    end
  end

end

#class Relation < ActiveRecord::Base
#   belongs_to :article, :foreign_key => "article_id", :class_name => "Article"
#   belongs_to :related, :foreign_key => "related_id", :class_name => "Article"
#end