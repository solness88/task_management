FactoryBot.define do
  factory :task do
    task_name {'パリ'}
    detail {'ニューヨーク'}
    deadline {'ロンドン'}
    status {'マドリード'}
    priority {'モスクワ'}
  end
  factory :second_task, class: Task do
    task_name {'高雄'}
    detail {'ジャカルタ'}
    deadline {'バンコク'}
    status {'福岡'}
    priority {'ソウル'}
  end
end
