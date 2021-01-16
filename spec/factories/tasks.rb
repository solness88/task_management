FactoryBot.define do
  factory :task do
    task_name {'３番目に作成したタスク'}
    detail {'期限が最も遅いタスク'}
    deadline {'002020-01-01'}
    status {'完了'}
    priority {'ロンドン'}
  end
  factory :second_task, class: Task do
    task_name {'２番目に作成したタスク'}
    detail {'期限が２番目に早いタスク'}
    deadline {'002019-01-01'}
    status {'着手'}
    priority {'ヤンゴン'}
  end
  factory :third_task, class: Task do
    task_name {'最初に作成したタスク'}
    detail {'期限が最も早いタスク'}
    deadline {'002018-01-01'}
    status {'未着手'}
    priority {'ソウル'}
  end
end
