class ProjectsController < ApplicationController
  def index
    @project_categories = ProjectCategory.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @project = Project.find_by_subdomain!(params[:subdomain] || request.subdomain)
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def lectures_subscribe
    # show lecture and subscribe to lecture
    @project = Project.find_by_subdomain!(params[:subdomain] || request.subdomain)
    if not @project.is_lectures?
      not_found
    end
    @articles = @project.articles.announces.map{|a| [a.title, a.id]}

    @subscriber = LectureSubscriber.new(params[:lecture_subscriber])

    # check if user has site cookie and probably was subscribed before to any lecture
    @subscribed = false
    @introduced = false
    cookie_value = read_cookie
    if cookie_value
      @introduced = true
      @subscriber.email = cookie_value[:email]
      @subscriber.name = cookie_value[:name]
      # check if user already subscribed to this lecture
#      if cookie_value[:articles].include? @article.id
#        @subscribed = true
#      end
    end

    respond_to do |format|
      if params[:lecture_subscriber] and @subscriber.save

        # update cookie
        if not cookie_value
          cookie_value = {
            :name => @subscriber.name,
            :email => @subscriber.email,
            :articles => [],
          }
        end
        cookie_value[:articles] += [@subscriber.article.id]
        set_cookie(cookie_value)

        # send email
        LectureSubscriberMailer.subscribe_email(@subscriber).deliver
        format.js
      else
        format.html
      end
    end
  end

  def lectures_unsubscribe
    # unsubscribe from lecture
    cookie_value = read_cookie

    # delete all subscribers from this lecture with this email
    LectureSubscriber.where('email = ? AND article_id = ?', cookie_value[:email], @article.id).destroy_all

    # update cookie
    cookie_value[:articles] -= [@article.id]
    set_cookie(cookie_value)

    respond_to do |format|
        format.js
      end
    end
  end

  def set_cookie(value)
    cookies[:subscribe] = {:expires => 5.year.from_now, :value => Marshal::dump(value)}
  end

  def read_cookie
    if cookies[:subscribe]
      Marshal::load(cookies[:subscribe])
    else
      nil
  end

end