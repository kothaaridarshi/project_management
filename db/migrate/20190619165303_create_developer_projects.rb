class CreateDeveloperProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :developer_projects do |t|
      t.integer :developer_id
      t.integer :project_id

      t.timestamps
    end
  end
end
