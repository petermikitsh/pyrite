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
    @project.owner_id = current_user.id

    respond_to do |format|
      if @project.save
        format.html { redirect_to root_url, notice: 'Project was successfully created.' }
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
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def addUser
    @user = User.where(:login => params[:user_login])
    @project = Project.find(params[:project_id])
    @project.users.push(@user) unless @user.nil?
    render :partial => 'layouts/settings', :@project => @project

  end

  def removeUser
    @user = User.where(:login => params[:user_login]).first
    @project = Project.find(params[:project_id])
    @project.users.delete(@user) unless (@user.nil? || @user.id == @project.owner_id)
    render :partial => 'layouts/settings', :project => @project
  end

  def toBib
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
      params.require(:project).permit(:name, :owner_id, :user_login)
    end
end
