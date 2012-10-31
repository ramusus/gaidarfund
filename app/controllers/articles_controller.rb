class ArticlesController < ApplicationController
  def news
    @type_ids = Articletype.news.find(:all).map(&:id)
    @menu_class = 'news'
    render "index"
  end

  def publications
    @type_ids = Articletype.not_news.not_announce.find(:all).map(&:id)
    @menu_class = 'articles'
    render "index"
  end

  def announces
    @type_ids = Articletype.announce.find(:all).map(&:id)
    @menu_class = 'announces'
    render "index"
  end

  def list
    articles = Article.visible
    if not params[:type_ids].blank?
      articles = articles.scoped_by_articletype_id(params[:type_ids].split(','))
    end
    if not params[:project_ids].blank?
      articles = articles.scoped_by_project_id(params[:project_ids].split(','))
    end

    params[:page] = params[:page].to_i
    per_page = Article.per_page
    if params[:page] == 1
      @article_main = articles.main.first
      #less ammount, becouse of first main article
      per_page = per_page - 1
    end
    @articles = articles.where("id != ?", @article_main ? @article_main.id: 0).paginate(:page => params[:page], :per_page => per_page)
    render :layout => false
  end

  def show
    @article = Article.find(params[:id])

    articles = Article.visible.where("articletype_id = ?", @article.articletype_id)
    if @article.project
      articles = articles.where("project_id = ?", @article.project_id)
    else
      articles = articles.where("project_id < 1") # becouse in mysql value is 0, in postgres NULL
    end
    @next = articles.where("published_at > ?", @article.published_at).last
    @previous = articles.where("published_at < ?", @article.published_at).first
    @more = articles.where("id != ?", @article.id).limit(5)

    if @article.project
      @menu_class = 'projects'
    elsif @article.type.id == Articletype::PUBLICATION_ID
      @menu_class = 'articles'
    elsif @article.type.id == Articletype::NEWS_ID
      @menu_class = 'news'
    end

    respond_to do |format|
      format.html # show.html.erb
    end
  end
end