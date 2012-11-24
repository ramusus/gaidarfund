module ArticlesHelper

  def article_path(article)
    if not article.url.blank?
      article.url
    elsif article.project
      polymorphic_url(article, :subdomain => article.project.subdomain)
    else
      polymorphic_url(article, :subdomain => '')
    end
  end

end