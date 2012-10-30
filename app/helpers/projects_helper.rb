module ProjectsHelper

  def project_path(project)
    root_url(:subdomain => project.subdomain)
  end

end