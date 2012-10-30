class PagesController < ApplicationController
  def show
    pages = Page.all
    if request.subdomain and project = Project.find_by_subdomain(request.subdomain)
      pages = Page.where("project_id = ?", project.id)
    else
      pages = Page.where("project_id is NULL OR project_id = 0") # for pg and mysql TODO: find more clean way via ORM
    end

    @page = pages.find_by_slug(params[:slug] || '') || not_found

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
