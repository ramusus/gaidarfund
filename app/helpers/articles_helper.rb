module ArticlesHelper

  def article_path(article)
    puts article
    if article.project
      polymorphic_url(article, :subdomain => article.project.subdomain)
    else
      super
    end
  end

end