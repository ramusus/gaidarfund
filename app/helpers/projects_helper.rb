module ProjectsHelper

  def project_path(project)
    not project.url.blank? and project.url or root_url(:subdomain => project.subdomain)
  end

end