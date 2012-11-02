# -*- coding: utf-8 -*-
class ArticlesController < ApplicationController

  # for right method article_path here in controller
  include ArticlesHelper

  def news
    @type_ids = Articletype.news.find(:all).map(&:id)
    @menu_class = 'news'
    @title = 'Новости'
    render "index"
  end

  def publications
    @type_ids = Articletype.not_news.not_announce.find(:all).map(&:id)
    @menu_class = 'articles'
    @title = 'Публикации'
    render "index"
  end

  def announces
    @type_ids = Articletype.announce.find(:all).map(&:id)
    @menu_class = 'announces'
    @title = 'Анонсы'
    render "index"
  end

  def show_old_news
    redirect_to Article.news.find_by_old_id!(params[:id]) or not_found
  end

  def show_old_publication
    redirect_to Article.publications.find_by_old_id(params[:id]) or not_found
  end

  def show_old_announce
    redirect_to Article.announces.find_by_old_id(params[:id]) or not_found
  end

  def show
    @article = Article.find(params[:id]) or not_found

    if @article.project
      @menu_class = 'projects'
      # redirect to right subdomain
      if not Subdomain.matches?(request)
        redirect_to article_path(@article) and return
      end
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

    params[:page] = params[:page].to_i
    params[:per_page] = params[:per_page].to_i
    if params[:page] == 1
      @article_main = articles.main.first
      # decrease ammount per page, becouse of first main article
      params[:per_page] = params[:per_page] - 1
    end
    @articles = articles.where("id != ?", @article_main ? @article_main.id: 0).paginate(:page => params[:page], :per_page => params[:per_page])
    render :layout => false
  end

end