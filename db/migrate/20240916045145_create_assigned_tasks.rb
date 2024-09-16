class CreateAssignedTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :assigned_tasks do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
