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

  def memories_3goda_bez
    @articles = Article.visible.scoped_by_articletype_id(Articletype::MEMORY_ID)
    render :layout => false
  end

  def articles_by_type
    @type = Articletype.find_by_slug(params[:slug])
    @type_ids = @type.id
    @menu_class = @type.color_class
    @title = @type.title
    render "index"
  end

  def show_old_news
    redirect_to Article.news.find_by_old_id(params[:id]) || news_path
  end

  def show_old_announce
    redirect_to Article.announces.find_by_old_id(params[:id]) || announces_path
  end

  def show_old_publication
    redirect_to Article.not_news.not_announces.find_by_old_id(params[:id]) || publications_path
  end

  def show
    @article = Article.find(params[:id]) || not_found

    # redirect to right subdomain
    if @article.project and not Subdomain.matches?(request)
      redirect_to article_path(@article) and return
    end

    # redirect to forbidden if article only for signed
    if @article.only_for_signed and not user_signed_in?
      return forbidden
    end

    if @article.type.page and not @article.project
      @menu_class = @article.type.page.color_class
    elsif @article.project
      @menu_class = 'projects'
    elsif @article.is_news?
      @menu_class = 'news'
    else
      @menu_class = 'articles'
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
    if not params[:index].blank?
      articles = articles.visible_on_index
    end
    if not params[:type_ids].blank?
      articles = articles.scoped_by_articletype_id(params[:type_ids].split(','))
    end
    if not params[:project_ids].blank?
      articles = articles.scoped_by_project_id(params[:project_ids].split(','))
      # hide announces from past
      articles = articles.where('published_at > ? AND articletype_id = ? OR articletype_id != ?', Time.now, Articletype::ANNOUNCE_ID, Articletype::ANNOUNCE_ID)
    end

    if params[:query].blank?
      if not params[:project_ids].blank?
        @article_main = articles.main_for_project.first
      else
        @article_main = articles.main.first
      end
    end
    articles = articles.where("id != ?", @article_main ? @article_main.id: 0)
    types_count = {}

    params[:page] = params.fetch(:page, 1).to_i
    params[:per_page] = params.fetch(:per_page, 20).to_i
    if not params[:query].blank?
      Articletype.all.each do |type|
        types_count[type.id] = Article.search(params[:query], :with => {:id => articles.map(&:id), :articletype_id => type.id}).count()
      end
      order = params[:order] == 'relevance' ? "@relevance DESC" : "published_at DESC"
      articles = Article.search(params[:query], :order => order, :with => {:id => articles.map(&:id)}, :page => params[:page], :per_page => params[:per_page])
    else
      articles = articles.paginate(:page => params[:page], :per_page => params[:per_page])
    end

    @articles = articles

    respond_to do |format|
       format.json { render :json => {:types_count => types_count, :content => render_to_string(:layout => false)}}
       format.rss { render :layout => false }
    end
  end

end