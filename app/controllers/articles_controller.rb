class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @article_main = Article.where(:main => true).first
    @articles = Article.where("id != ?", @article_main ? @article_main.id: 0)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  def news
    @article_main = Article.where(:main => true, :articletype_id => 4).first
    @articles = Article.where(:articletype_id => 4).where("id != ?", @article_main ? @article_main.id: 0)
    @menu_class = 'news'
    render "index"
  end

  def publications
    @article_main = Article.where(:main => true, :articletype_id => 1).first
    @articles = Article.where(:articletype_id => 1).where("id != ?", @article_main ? @article_main.id: 0)
    @menu_class = 'articles'
    render "index"
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    if @article.project
      @menu_class = 'projects'
    elsif @article.type.id == 1
      @menu_class = 'articles'
    elsif @article.type.id == 4
      @menu_class = 'news'
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end
end