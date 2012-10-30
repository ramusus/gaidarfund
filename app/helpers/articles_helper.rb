module ArticlesHelper

  def article_path(options)
    if options.project
      polymorphic_url(options, :subdomain => options.project.subdomain)
    else
      super
    end
  end

end