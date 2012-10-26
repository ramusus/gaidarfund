class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale, :set_context

  def set_context

    @projects = Project.all
    @blogs = Blog.all

    ['partners','banners_right_column'].each do |var_name|
      chunk = Chunk.find_by_code(var_name)
      if chunk and chunk.visible
        chunk = chunk.content.html_safe
      else
        chunk = ''
      end
      self.instance_variable_set('@' + var_name, chunk)
    end

  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def index
  end

end