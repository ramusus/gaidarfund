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
    @article_main = Article.where("main=True AND project_id = ?", @project.id).first
    @articles = Article.where("id != ? AND project_id = ?", @article_main ? @article_main.id: 0, @project.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subproject }
    end
  end

  # GET /subprojects/new
  # GET /subprojects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subproject }
    end
  end

  # GET /subprojects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /subprojects
  # POST /subprojects.json
  def create
    @project = Project.new(params[:subproject])

    respond_to do |format|
      if @subproject.save
        format.html { redirect_to @subproject, notice: 'Project was successfully created.' }
        format.json { render json: @subproject, status: :created, location: @subproject }
      else
        format.html { render action: "new" }
        format.json { render json: @subproject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subprojects/1
  # PUT /subprojects/1.json
  def update
    @subproject = Project.find(params[:id])

    respond_to do |format|
      if @subproject.update_attributes(params[:subproject])
        format.html { redirect_to @subproject, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subproject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subprojects/1
  # DELETE /subprojects/1.json
  def destroy
    @subproject = Project.find(params[:id])
    @subproject.destroy

    respond_to do |format|
      format.html { redirect_to subprojects_url }
      format.json { head :no_content }
    end
  end
end
