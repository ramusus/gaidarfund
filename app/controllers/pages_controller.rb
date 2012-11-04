class PagesController < ApplicationController
  def show
    if not request.subdomain.empty? and project = Project.find_by_subdomain(request.subdomain)
      pages = Page.where("project_id = ?", project.id)
    else
      pages = Page.where("project_id is NULL")
    end

    @page = pages.find_by_slug(params[:slug] || '') or not_found

    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
