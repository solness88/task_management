class Task < ApplicationRecord
  validates :task_name, presence: true, uniqueness: true
  validates :detail, presence: true, length:{maximum:50}
  validates :deadline, presence: true
  scope :task_name, -> (task_name) { where('task_name LIKE ?', "%#{task_name}%") }
  scope :status, -> (status) { where(status: status) }
  enum priority: { 高:0, 中:1, 低:2 }
  belongs_to :user
  has_many :labellings, dependent: :destroy
  #paginates_per 10
end
