class DeveloperProject < ApplicationRecord
	# Associations
	belongs_to :project
	belongs_to :user, foreign_key: :developer_id
	after_destroy :remove_task_assignements

	private

	def remove_task_assignements
		Task.where(project_id: project_id, developer_id: developer_id).update_all(developer_id: nil)
	end
end
