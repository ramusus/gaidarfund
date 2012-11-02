class ProjectsController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @project = Project.find_by_subdomain!(request.subdomain)

    respond_to do |format|
      format.html # show.html.erb
    end
  end
end
