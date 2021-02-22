User.create(name:"adminuser",
            email:"adminuser@adminuser.com",
            password:"12345qwert",
            password_confirmation:"12345qwert",
            admin:true)

10.times do |n|
  User.create(name:"user#{n}",
              email:"user#{n}@user#{n}.com",
              password:"12345qwert",
              password_confirmation:"12345qwert")
end

10.times do |n|
  Task.create(task_name: "#{n}番目のタスク",
              detail:"#{n}番目のタスクの詳細",
              deadline:"002020-01-01",
              status:"着手中",
              priority:"高",
              user_id: n)
end

10.times do |n|
  Label.create(name: "#{n}番目のラベル")
end
