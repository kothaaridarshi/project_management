class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	
	# Association
	belongs_to :role
	has_many :projects, dependent: :destroy, foreign_key: :admin_id
	has_many :tasks, dependent: :destroy, foreign_key: :developer_id
	has_many :developer_projects, dependent: :destroy, foreign_key: :developer_id
	has_many :dev_projects, -> { distinct },through: :developer_projects, source: :project

	# Callbacks
	before_validation :set_role

	# Scopes
	scope :admin_users, -> { where(role_id: Role.find_by_name('admin')).select(:email, :id) }
	scope :dev_users, -> { where(role_id: Role.find_by_name('developer')).select(:email, :id) }


	def admin?
		role_id.eql?(Role.find_by_name('admin').id)
	end

	private

	def set_role
  	self.role ||= Role.find_by_name('developer')
	end        
end
