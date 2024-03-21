class FavoriteTasksSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :desc

  has_many :schedules

  attribute :schedules do |task|
    ScheduleSerializer.new(task.schedules).serializable_hash[:data].map { |data| data[:attributes] }
  end

end
