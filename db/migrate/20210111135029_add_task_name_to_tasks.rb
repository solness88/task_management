class AddTaskNameToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :task_name, :string
  end
end
