class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    render layout: false
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.users = [current_user]

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def addUser
    user = User.where(:login => params[:user_login])
    Project.find(params[:project_id]).users.push(User.where(:login => params[:user_login])) unless user.nil?
    logger.debug "STUFFFFFF_THIS #{params[:project_id]}"
    render :partial => 'layouts/settings', :@project => Project.find(params[:project_id])

  end

  def removeUser
    logger.debug "STUFFFFFF2 PROJ:#{params[:project_id]} USER:#{params[:user_login]}"
    user = User.where(:login => params[:user_login])
    Project.find(params[:project_id]).users.delete(User.where(:login => params[:user_login])) unless user.nil?
    render :partial => 'layouts/settings', :@project => Project.find(params[:project_id])
  end

  def toBib
    # render :text => format.html_content
    render 'projects/bibliography_format', layout: false
  end

  def left
    render 'layouts/left_navbar', layout: false
  end

  def settings
    render 'projects/settings', layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      # params.require(:project).permit(:name, :owner_id, :user_login)
    end
end
