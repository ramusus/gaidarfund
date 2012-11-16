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
      include_fields :title, :slug, :project, :page, :position
    end
    show do
      include_fields :title, :slug
      include_fields :content do
        pretty_value do
          value.html_safe
         end
      end
    end
    edit do
      include_fields :title, :slug
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
      include_fields :published_at, :title, :project, :articletype, :main
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
      include_fields :only_for_signed do
        help 'Материал скрывается из всех листингов и доступен по прямой ссылке только авторизованным'
      end
      include_fields :published_at do
      end
      include_fields :title_seo do
        help 'Сео заголовок (если пуст, то по умолчанию выводистя title материала)'
      end
      include_fields :content do
        help 'Основной блок материала'
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

  config.model Project do
    list do
      include_fields :title, :subdomain, :hide, :position
    end
    edit do
      include_fields :title do
        help 'Заголовок проекта на странице проекта'
      end
      include_fields :title_short do
        help 'Короткий заголовок проекта в листингах и меню'
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
      include_fields :position do
        help ''
      end
      include_fields :hide do
        help 'Скрыть проект в автоматических листингах проекта'
      end
      include_fields :hide_sidebar do
        help 'Скрыть проект в левом меню проекта'
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
          help ' Содержимое блока справа от ленты'
        end
        field :html_block do
          help 'Произвольный блок, добавляется перед лентой (может содержать, например, краткое описание проекта или баннер)'
        end
        field :partners do
          help 'Нижний блок партнеров перед подвалом'
        end
        field :counters do
          help 'Коды счетчиков только для подпроекта (по умолчанию добавляется общий счетчик)'
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