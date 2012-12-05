class LecturesController < ApplicationController

  def subscribe
    # show lecture and subscribe to lecture
    @project = Project.find_by_subdomain!(params[:subdomain] || request.subdomain)
    if not @project.is_lectures?
      not_found
    end

    @articles = @project.lectures_active.order("published_at ASC")
    @articles_subscribed = []

    @subscriber = LectureSubscriber.new(params[:lecture_subscriber])

    # check if user has site cookie and probably was subscribed before to any lecture
    cookie_value = read_cookie(:subscribe)
    if cookie_value
      @subscriber.email = cookie_value[:email]
      @subscriber.name = cookie_value[:name]
      @articles_subscribed = cookie_value[:articles] || []
    end

    respond_to do |format|
      if params[:lecture_subscriber]

        # delete all subscribers from this lecture with this email
        @articles.each do |article|
          LectureSubscriber.where('email = ? AND article_id = ?', @subscriber.email, article.id).destroy_all
        end

        params.fetch(:articles, []).each do |id|
          @subscriber.article = Article.find(id)
          @subscriber.save
        end

        # update cookie
        if not cookie_value
          cookie_value = {
            :name => @subscriber.name,
            :email => @subscriber.email,
            :articles => [],
          }
        end
        cookie_value[:articles] = params[:articles]
        set_cookie(:subscribe, cookie_value)

        # send email
        if params[:articles]
          LectureSubscriberMailer.subscribe_email(@subscriber, params[:articles]).deliver
        end
        format.js
      else
        format.html
      end
    end
  end

end