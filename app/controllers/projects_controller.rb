class ProjectsController < ApplicationController
  # GET /subprojects
  # GET /subprojects.json
  def index
    @subprojects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subprojects }
    end
  end

  # GET /subprojects/1
  # GET /subprojects/1.json
  def show
    @project = Project.find_by_subdomain!(request.subdomain)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subproject }
    end
  end
end
