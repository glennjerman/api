class Schedule < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :favorite_task, optional: true

  validate :task_or_favorite_task

  private

  def task_or_favorite_task
    errors.add(:base, "A schedule must belong to a task or a favorite task.") unless task || favorite_task
  end
end
