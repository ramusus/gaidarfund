class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale, :set_context

  def set_context

    @articletypes = Articletype.where("id != ?", 7)
    @projects = Project.all
    @blogs = Blog.all

    ['partners','banners_right_column','footer_links_1','footer_links_2','golden_fund','social_likes','social_links','extra_head','projects_introduction'].each do |var_name|
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