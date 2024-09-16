class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  # Returns the email of the user who the task is assigned to.
  # The task to check is passed as an argument.
  #
  # @param task [Task] The task to check.
  # @return [String] The email of the user who the task is assigned to.
  def user_email
    assigned_task = AssignedTask.find_by(task_id: id)
    assigned_task&.user&.email
  end
end
