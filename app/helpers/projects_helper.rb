module ProjectsHelper

  def project_path(project)
    not project.url.blank? ? project.url : root_url(:subdomain => project.subdomain)
  end

end