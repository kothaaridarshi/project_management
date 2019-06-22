class DashboardsController < ApplicationController
	def index
		if current_user.admin?
			@tasks = Task.joins(:project).where('projects.admin_id = ?', current_user.id).select(:id, :feature_name)
			@developers = User.where(id: Task.where(id: @tasks&.pluck(:id)).select(:developer_id)).select(:email, :id)
			@projects = Project.where(id: Task.where(id: @tasks&.pluck(:id)).select(:project_id)).select(:name, :id)
		else
			@tasks = current_user.tasks.includes(:project)
		end
	end
end