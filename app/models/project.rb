class Project < ApplicationRecord
	# Association
	has_many :tasks, dependent: :destroy
	belongs_to :user, foreign_key: :admin_id
	has_many :developer_projects, dependent: :destroy
	has_many :dev_users, -> { distinct }, through: :developer_projects, source: :user

	# Validations
	validates :name, :description, presence: true
end
