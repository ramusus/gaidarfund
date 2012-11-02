module ProjectsHelper

  def project_path(project)
    project.url or root_url(:subdomain => project.subdomain)
  end

end