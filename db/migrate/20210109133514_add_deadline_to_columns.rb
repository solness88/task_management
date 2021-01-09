class AddDeadlineToColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :date, after: :detail
  end
end
