50.times do |n|
  task_name = Faker::Games::Pokemon.name
  detail = Faker::JapaneseMedia::DragonBall.character
  deadline = Faker::Date.in_date_period
  status = Faker::Military.air_force_rank
  priority = Faker::Mountain.name
  Task.create!(task_name: task_name,
               detail: detail,
               deadline: deadline,
               status: status,
               priority: priority
               )
end
