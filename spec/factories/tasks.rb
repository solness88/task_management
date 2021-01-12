FactoryBot.define do
  factory :task do
    task_name {'上から３番目のタスク'}
    detail {'ニューヨーク'}
    deadline {'2020-01-01'}
    status {'マドリード'}
    priority {'ロンドン'}
  end
  factory :second_task, class: Task do
    task_name {'上から２番目のタスク'}
    detail {'ジャカルタ'}
    deadline {'2019-01-01'}
    status {'ヤンゴン'}
    priority {'ソウル'}
  end
  factory :third_task, class: Task do
    task_name {'一番上に表示したいタスク'}
    detail {'ジャカルタ'}
    deadline {'2018-01-01'}
    status {'ヤンゴン'}
    priority {'ソウル'}
  end
end
