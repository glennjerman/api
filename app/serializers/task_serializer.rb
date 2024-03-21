class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :desc, :completed
  attribute :created_at do |object|
    object.created_at.strftime("%m/%d/%Y")
  end

  has_many :schedules

  attribute :schedules do |task|
    ScheduleSerializer.new(task.schedules).serializable_hash[:data].map { |data| data[:attributes] }
  end

end
