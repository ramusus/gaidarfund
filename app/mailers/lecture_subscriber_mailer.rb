# -*- coding: utf-8 -*-
class LectureSubscriberMailer < ActionMailer::Base
  default :from => "no-reply@gaidarfund.ru"

  def subscribe_email(subscriber)
    @subscriber = subscriber
    mail(:to => subscriber.email, :subject => "Запись на лекцию #{Russian.strftime(subscriber.article.published_at, '%d %B')}")
  end

end