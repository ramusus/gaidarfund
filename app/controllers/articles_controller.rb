class ArticlesController < ApplicationController
  def news
    @article_main = Article.main.visible.news.first
    @articles = Article.visible.news.where("id != ?", @article_main ? @article_main.id: 0)
    @menu_class = 'news'
    render "index"
  end

  def publications
    @article_main = Article.main.visible.publications.first
    @articles = Article.visible.publications.where("id != ?", @article_main ? @article_main.id: 0)
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