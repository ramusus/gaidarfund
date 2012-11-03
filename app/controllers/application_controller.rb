class ApplicationController < ActionController::Base

  include ExceptionLogger::ExceptionLoggable # loades the module
  rescue_from Exception, :with => :log_exception_handler # tells rails to forward the 'Exception' (you can change the type) to the handler of the module

  protect_from_forgery
  before_filter :set_locale, :set_context

  def set_context

    @articletypes = Articletype.where("id != ?", 7)
    @projects = Project.visible.all
    @blogs = Blog.all

    ['partners','banners_right_column','footer_links_1','footer_links_2','golden_fund','social_likes','social_links','extra_head','projects_introduction','yandex_metrica_gaidarfund','yandex_metrica_all'].each do |var_name|
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
    @announces = Article.announces.where("published_at >= ?", Time.now)
    @slides = Slide.limit(5)

    @type_ids = Articletype.not_announce.find(:all).map(&:id)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end