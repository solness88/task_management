FactoryBot.define do
  factory :task do
    task_name {'上から３番目のタスク'}
    detail {'ニューヨーク'}
    deadline {'ロンドン'}
    status {'マドリード'}
    priority {'モスクワ'}
  end
  factory :second_task, class: Task do
    task_name {'上から２番目のタスク'}
    detail {'ジャカルタ'}
    deadline {'バンコク'}
    status {'ヤンゴン'}
    priority {'ソウル'}
  end
  factory :third_task, class: Task do
    task_name {'一番上に表示したいタスク'}
    detail {'ジャカルタ'}
    deadline {'バンコク'}
    status {'ヤンゴン'}
    priority {'ソウル'}
  end
end
