Doslovno::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[Gaidarfund] ",
  :sender_address => %{"no-reply" <no-reply@gaidarfund.ru>},
  :exception_recipients => %w{ramusus@gmail.com}