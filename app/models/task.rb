class Task < ApplicationRecord
	# Associations
	belongs_to :project
	belongs_to :user, foreign_key: :developer_id, optional: true

	# Validations
	validates :feature_name, :description, presence: true

	# Enums
	enum statuses: [:todo, :in_progess, :done]
end
