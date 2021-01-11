class ChangeColumnDetail < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :detail, :text, limit:30
  end
end
