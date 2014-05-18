# -*- coding: utf-8 -*-
class LecturesController < ApplicationController

  def subscribe
    # show lecture and subscribe to lecture
    @project = Project.find_by_subdomain!(params[:subdomain] || request.subdomain)
    if not @project.is_lectures? and not @project.is_club?
      not_found
    end

    @articles = @project.events_active
    @articles_subscribed = []

    respond_to do |format|
      if params[:lecture_subscriber]

        # delete all subscribers from this lecture with this email
        @articles.each do |article|
          LectureSubscriber.where('email = ? AND article_id = ?', params[:lecture_subscriber][:email], article.id).destroy_all
        end

        params.fetch(:articles, []).each do |id|
          @subscriber = LectureSubscriber.new(params[:lecture_subscriber])
          @subscriber.article = Article.find(id)
          @subscriber.save
        end

        # update cookie
        cookie_value = {
          :name => @subscriber.name,
          :email => @subscriber.email,
          :articles => params[:articles],
        }
        set_cookie(:subscribe, cookie_value)

        # send email
        if params[:articles]
          begin
            LectureSubscriberMailer.subscribe_email(@subscriber, params[:articles]).deliver
          rescue Net::SMTPFatalError
            @error = 'Пользователь с таким почтовым адресом не найден'
          end
        end

        format.js

      else

        @subscriber = LectureSubscriber.new()

        # check if user has site cookie and probably was subscribed before to any lecture
        cookie_value = read_cookie(:subscribe)
        if cookie_value
          @subscriber.email = cookie_value[:email]
          @subscriber.name = cookie_value[:name]
          @articles_subscribed = cookie_value[:articles] || []
        end

        format.html

      end
    end
  end

end