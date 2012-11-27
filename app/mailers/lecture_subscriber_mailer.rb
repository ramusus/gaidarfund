# -*- coding: utf-8 -*-
class LectureSubscriberMailer < ActionMailer::Base
  default :from => "no-reply@gaidarfund.ru"

  def subscribe_email(subscriber, article_ids)
    @subscriber = subscriber
    @articles = Article.find(article_ids)
    mail(:to => subscriber.email, :subject => "Запись на лекции фонда Егора Гайдара")
  end

end