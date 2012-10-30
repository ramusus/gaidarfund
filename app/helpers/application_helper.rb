module ApplicationHelper
  include UrlHelper

  def project_path(project)
    root_url(:subdomain => project.subdomain)
  end

  def article_path(options)
    if options.project
      polymorphic_url(options, :subdomain => options.project.subdomain)
    else
      super
    end
  end

end