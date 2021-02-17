FactoryBot.define do
  factory :task do
    task_name {'３番目に作成したタスク'}
    detail {'期限が最も遅いタスク'}
    deadline {'002020-01-01'}
    status {'完了'}
    priority {'高'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :second_task, class: Task do
    task_name {'２番目に作成したタスク'}
    detail {'期限が２番目に早いタスク'}
    deadline {'002019-01-01'}
    status {'着手'}
    priority {'中'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :third_task, class: Task do
    task_name {'最初に作成したタスク'}
    detail {'期限が最も早いタスク'}
    deadline {'002018-01-01'}
    status {'未着手'}
    priority {'低'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :fourth_task, class: Task do
    task_name {'タスク1'}
    detail {'タスク1の詳細'}
    deadline {'002017-01-01'}
    status {'完了'}
    priority {'高'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :fifth_task, class: Task do
    task_name {'タスク2'}
    detail {'タスク2の詳細'}
    deadline {'002016-01-01'}
    status {'未着手'}
    priority {'中'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :sixth_task, class: Task do
    task_name {'タスク3'}
    detail {'タスク3の詳細'}
    deadline {'002015-01-01'}
    status {'未着手'}
    priority {'低'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :seventh_task, class: Task do
    task_name {'３番目に作成したタスク'}
    detail {'期限が最も遅いタスク'}
    deadline {'002020-01-01'}
    status {'完了'}
    priority {'高'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :eighth_task, class: Task do
    task_name {'２番目に作成したタスク'}
    detail {'期限が２番目に早いタスク'}
    deadline {'002019-01-01'}
    status {'着手'}
    priority {'中'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :ninth_task, class: Task do
    task_name {'最初に作成したタスク'}
    detail {'期限が最も早いタスク'}
    deadline {'002018-01-01'}
    status {'未着手'}
    priority {'低'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :tenth_task, class: Task do
    task_name {'タスク1'}
    detail {'タスク1の詳細'}
    deadline {'002017-01-01'}
    status {'完了'}
    priority {'高'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :eleventh_task, class: Task do
    task_name {'タスク2'}
    detail {'タスク2の詳細'}
    deadline {'002016-01-01'}
    status {'未着手'}
    priority {'中'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :twelveth_task, class: Task do
    task_name {'タスク3'}
    detail {'タスク3の詳細'}
    deadline {'002015-01-01'}
    status {'未着手'}
    priority {'低'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :thirteenth_task, class: Task do
    task_name {'タスク3'}
    detail {'タスク3の詳細'}
    deadline {'002015-01-01'}
    status {'未着手'}
    priority {'低'}
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
end
