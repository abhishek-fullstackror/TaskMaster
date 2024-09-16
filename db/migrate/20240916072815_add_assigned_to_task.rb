class AddAssignedToTask < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :assigned, :boolean,default: false
  end
end
