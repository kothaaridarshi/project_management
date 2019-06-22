class TasksController < ApplicationController
	before_action :set_project
	before_action :set_task, except: [:new, :create, :index]

	def new
		@task = @project.tasks.new
		authorize @task
		@dev_users = @project.dev_users
	end

	def create
		@task = @project.tasks.new(task_params)
		authorize @task
		if @task.save
			redirect_to project_tasks_path(@project), notice: 'Task added successfully'
		else
			@dev_users = @project.dev_users
			render :new
		end
	end

	def index
		raise Pundit::NotAuthorizedError unless TaskPolicy.new(current_user, [], {project_id: @project.id}).index?
		@tasks = @project.tasks.all
	end

	def show
		authorize @task
	end

	def edit
		authorize @task
		@dev_users = @project.dev_users
	end

	def update
		authorize @task
		if @task.update(task_params)
			redirect_to project_tasks_path(@project), notice: 'Task updated successfully'
		else
			@dev_users = @project.dev_users
			render :edit
		end
	end

	def destroy
		authorize @task
		if @task.destroy
			redirect_to project_tasks_path(@project), notice: 'Task deleted successfully'
		else
			redirect_to project_tasks_path(@project), notice: 'Task not deleted'
		end
	end

	def status_update
		authorize @task
		return render json: {message: 'Status not updated'} unless @task.present?
		if @task.update(status: params[:status])
			render json: {message: 'Status updated successfully'}
		else
			render json: {message: 'Status not updated'}
		end
	end

	private

	def set_project
		@project = Project.find_by(id: params[:project_id])
	end

	def set_task
		@task = @project.tasks.find_by(id: params[:id])
	end

	def task_params
		params.require(:task).permit(:feature_name, :description, :project_id, :developer_id)
	end

end