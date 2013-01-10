# -*- coding: utf-8 -*-
# RailsAdmin config file. Generated on October 20, 2012 21:50
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Gaidarfund', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = []

  # Include specific models (exclude the others):
  # config.included_models = []

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:

  config.model Page do
    list do
      include_fields :title, :slug, :project, :page, :visible, :position
    end
    show do
      include_fields :title, :slug, :visible
      include_fields :content do
        pretty_value do
          value.html_safe
         end
      end
    end
    edit do
      include_fields :title, :slug
      include_fields :visible do
        help 'Отображать ссылку на страницу в автоматических листингах'
      end
      include_fields :project do
        help 'Принадлежность страницы проекту'
        associated_collection_scope do
          Proc.new { |scope|
            scope = scope.linkable
          }
        end
      end
      include_fields :page, :position
      include_fields :content do
        ckeditor true
        ckeditor_config_js '/javascripts/ckeditor/config.js'
      end
    end
  end

  config.model Article do
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
          <h3 class="title"><img src="/photo-url.jpg" alt="Имя Фамилия" /></div>Имя фамилия персоны</h3>
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

  config.model Chunk do
    list do
      include_fields :title, :code, :visible
    end
    edit do
      include_fields :title, :code, :visible, :content
#      include_fields :content do
#        ckeditor true
#        ckeditor_config_js '/javascripts/ckeditor/config.js'
#      end
    end
  end

  config.model StaticFile do
    list do
      include_fields :alt, :code, :file
    end
    edit do
      include_fields :alt, :code, :file
#      include_fields :content do
#        ckeditor true
#        ckeditor_config_js '/javascripts/ckeditor/config.js'
#      end
    end
  end

  config.model Slide do
    list do
      include_fields :title, :hide, :position
    end
    edit do
      include_fields :title, :hide, :color, :background_color, :link, :position, :top_text, :background_image
      include_fields :content do
        ckeditor true
        ckeditor_config_js '/javascripts/ckeditor/config.js'
      end
      field :color_class, :enum do
        enum_method do
          :color_class_enum
        end
      end

    end
  end

end