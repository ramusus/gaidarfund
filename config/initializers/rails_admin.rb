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
      include_fields :title, :slug, :project, :page
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
      include_fields :title, :slug, :project, :page
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
      include_fields :title, :subtitle, :image, :project, :articletype, :author, :main, :hide, :hide_discussions, :checked, :published_at, :title_seo
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
      include_fields :title, :code, :visible
      include_fields :content do
        ckeditor true
        ckeditor_config_js '/javascripts/ckeditor/config.js'
      end
    end
  end

  config.model Project do
    list do
      include_fields :title, :subdomain
    end
    edit do
      include_fields :title, :title_short, :subdomain, :color, :sign, :status, :core, :title_seo
      include_fields :likes, :partners, :counters, :right_block, :projects, :html_block do
        ckeditor true
        ckeditor_config_js '/javascripts/ckeditor/config.js'
      end

      group :text do
        label "Оформление"
        field :about_title
        field :news_title
        field :css
        field :background_image
        field :logo_image
        field :logo_small_image
      end

    end
  end

  config.model Slide do
    list do
      include_fields :title, :hide
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