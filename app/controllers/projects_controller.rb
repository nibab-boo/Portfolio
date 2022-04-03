class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]

  def index
    @projects = Project.all.order(updated_at: :desc)
  end
  
  def new
    @project = Project.new
  end

  def create
    # p "inside create"
    @project = Project.new(project_params)
    @project.fonts = JSON.parse(params["project"]["fonts"])
    @project.colors = JSON.parse(params["project"]["colors"])
    @project.languages = JSON.parse(params["project"]["languages"])
    # raise
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    @project.fonts = JSON.parse(params["project"]["fonts"])
    @project.colors = JSON.parse(params["project"]["colors"])
    @project.languages = JSON.parse(params["project"]["languages"])
    if @project.update(project_params)
      redirect_to projects_path
    else
      render :edit
    end
  end

  
  private 

  def project_params
    params.require(:project).permit(:name, :position, :experience, :link, :repo_link, :photos=> [])
  end


end
