FactoryBot.define do
  factory :task do
    task_name {'３番目に作成したタスク'}
    detail {'ニューヨーク'}
    deadline {'2020-01-01'}
    status {'完了'}
    priority {'ロンドン'}
  end
  factory :second_task, class: Task do
    task_name {'２番目に作成したタスク'}
    detail {'ジャカルタ'}
    deadline {'2019-01-01'}
    status {'着手'}
    priority {'ヤンゴン'}
  end
  factory :third_task, class: Task do
    task_name {'最初に作成したタスク'}
    detail {'ジャカルタ'}
    deadline {'2018-01-01'}
    status {'未着手'}
    priority {'ソウル'}
  end
end
