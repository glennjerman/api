class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :desc, :completed, :start_time, :end_time
  attribute :created_at do |object|
    object.created_at.strftime("%m/%d/%Y")
  end

  attribute :completed do |object|
    object.completed.map { |date| Date.parse(date).strftime("%m/%d/%Y") } if object.completed
  end

  has_many :schedules

  attribute :schedules do |task|
    ScheduleSerializer.new(task.schedules).serializable_hash[:data].map { |data| data[:attributes] }
  end

end
