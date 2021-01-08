class DeleteUniqueIndexFromTaskName < ActiveRecord::Migration[5.2]
  def change
    remove_index :tasks, :task_name
  end
end
