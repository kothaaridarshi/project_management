class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :feature_name, null: false
      t.text :description, null: false
      t.integer :developer_id
      t.integer :project_id
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
