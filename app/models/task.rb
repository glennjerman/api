class Task < ApplicationRecord
  belongs_to :user
  serialize :completed, JSON
  has_many :schedules, :dependent => :destroy
end
