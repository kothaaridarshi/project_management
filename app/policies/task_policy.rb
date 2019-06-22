class TaskPolicy < ApplicationPolicy
	def admin_rule
  	user.admin?
  end

  def record_access_rule
  	@record.project.admin_id.eql?(user.id)
  end

  def index?
  	admin_rule && Project.find(@data[:project_id]).admin_id.eql?(user.id) 
  end

  def new?
  	admin_rule && record_access_rule
  end

  def create?
  	admin_rule && record_access_rule
  end

  def show?
  	admin_rule && record_access_rule 
  end

  def edit?
  	admin_rule && record_access_rule
  end

  def update?
  	admin_rule && record_access_rule
  end

  def destroy?
  	admin_rule && record_access_rule
  end

  def status_update?
		record.developer_id.eql?(user.id)
	end
end