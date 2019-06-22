class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :edit, :update, :destroy, :chart]

	def new
		@project = current_user.projects.new
		authorize @project
		@dev_users = User.dev_users
		@selected_users = []
	end

	def create
		@project = current_user.projects.new(project_params)
		authorize @project
		if @project.save
			@project.dev_users << User.where(id: params[:developer_ids])
			redirect_to projects_path, notice: 'Project added successfully'
		else
			@dev_users = User.dev_users
			@selected_users = []
			render :new
		end
	end

	def index
		authorize Project
		@projects = current_user.projects.all
	end

	def show
		authorize @project
		@dev_users = @project.dev_users
	end

	def edit
		authorize @project
		@dev_users = User.dev_users
		@selected_users = @project.dev_users
	end

	def update
		authorize @project
		@selected_users = @project.dev_users
		if @project.update(project_params)
			manage_project_developers	
			redirect_to projects_path, notice: 'Project updated successfully'
		else
			@dev_users = User.dev_users
			render :edit
		end
	end

	def destroy
		authorize @project
		if @project.destroy
			redirect_to projects_path, notice: 'Project deleted successfully'
		else
			redirect_to projects_path, notie: 'Project not deleted'
		end
	end

	def chart
		authorize @project
		@chart_data = []
		@project.tasks.group(:status).count.map{|key, value| @chart_data.push([Task.statuses.invert[key].humanize, value])}
	end

	private

	def manage_project_developers
		selected_user_ids = @selected_users.pluck(:id)
		destroy_dev_ids = selected_user_ids - params[:developer_ids].map(&:to_i)	
		insert_dev_ids = params[:developer_ids].map(&:to_i) - selected_user_ids
		destroy_dev_ids.each do |dev_id|
			@project.dev_users.destroy(User.find(dev_id))
		end
		@project.dev_users << User.where(id: insert_dev_ids)
	end

	def set_project
		@project = Project.find_by(id: params[:id], admin_id: current_user.id)
	end

	def project_params
		params.require(:project).permit(:name, :description, :developer_ids)
	end

end