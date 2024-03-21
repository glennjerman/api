class ScheduleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday
end
