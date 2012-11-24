class ProjectsController < ApplicationController
  def index
    @project_categories = ProjectCategory.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @project = Project.find_by_subdomain!(params[:subdomain] || request.subdomain)

    respond_to do |format|
      format.html # show.html.erb
    end
  end
end
