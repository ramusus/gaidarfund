class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @article_main = Article.where("main=True").first
    @articles = Article.where("id != ?", @article_main ? @article_main.id: 0)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end
end