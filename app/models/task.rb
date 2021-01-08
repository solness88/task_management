class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :detail, presence: true, length:{maximum:50}
  validates :deadline, presence: true
end
