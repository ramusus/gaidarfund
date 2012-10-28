class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale, :set_context

  def set_context

    @projects = Project.all
    @blogs = Blog.all

    ['partners','banners_right_column','footer_links_1','footer_links_2','golden_fund'].each do |var_name|
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
    @events = Event.limit(5)
    @article_main = Article.visible.main.first
    @articles = Article.visible.where("id != ?", @article_main ? @article_main.id: 0)
  end

end