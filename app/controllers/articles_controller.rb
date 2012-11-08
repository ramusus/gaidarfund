# -*- coding: utf-8 -*-
class ArticlesController < ApplicationController

  # for right method article_path here in controller
  include ArticlesHelper

  def publications
    @type_ids = Articletype.not_news.not_announce.not_book.find(:all).map(&:id)
    @menu_class = 'articles'
    @title = 'Публикации'
    render "index"
  end

  def articles_by_type
    @type = Articletype.find_by_slug(params[:slug])
    @type_ids = @type.id
    @menu_class = @type.color_class
    @title = @type.title
    render "index"
  end

  def show_old_news
    redirect_to Article.news.find_by_old_id!(params[:id]) || news_path
  end

  def show_old_announce
    redirect_to Article.announces.find_by_old_id(params[:id]) || announces_path
  end

  def show_old_publication
    redirect_to Article.not_news.not_announces.find_by_old_id(params[:id]) || publication_path
  end

  def show
    @article = Article.find(params[:id]) || not_found

    # redirect to right subdomain
    if @article.project and not Subdomain.matches?(request)
      redirect_to article_path(@article) and return
    end

    # redirect to right subdomain
    if @article.published_at > Time.now and not user_signed_in?
      return forbidden
    end

    if @article.project
      @menu_class = 'projects'
    elsif @article.type.id == Articletype::PUBLICATION_ID
      @menu_class = 'articles'
    elsif @article.type.id == Articletype::NEWS_ID
      @menu_class = 'news'
    end

    articles = Article.visible.where("articletype_id = ?", @article.articletype_id)
    if @article.project
      articles = articles.where("project_id = ?", @article.project_id)
    else
      articles = articles.where("project_id < 1") # becouse in mysql value is 0, in postgres NULL
    end
    @next = articles.where("published_at > ?", @article.published_at).last
    @previous = articles.where("published_at < ?", @article.published_at).first
    @more = articles.where("id != ?", @article.id).limit(5)

    render "show"
  end

  def list
    articles = Article.visible
    if not params[:type_ids].blank?
      articles = articles.scoped_by_articletype_id(params[:type_ids].split(','))
    end
    if not params[:project_ids].blank?
      articles = articles.scoped_by_project_id(params[:project_ids].split(','))
    end

    params[:page] = params.fetch(:page, 1).to_i
    params[:per_page] = params.fetch(:per_page, 20).to_i
    @article_main = articles.main.first
    @articles = articles.where("id != ?", @article_main ? @article_main.id: 0).paginate(:page => params[:page], :per_page => params[:per_page])
    render :layout => false
  end

end