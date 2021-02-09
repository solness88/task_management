FactoryBot.define do
  factory :user do
    name {'tokyo'}
    email {'tokyo@tokyo.com'}
    password {'12345qwert'}
    password_confirmation {'12345qwert'}
  end
  factory :admin_user, class: User do
    name {'osaka'}
    email {'osaka@osaka.com'}
    password {'12345qwert'}
    password_confirmation {'12345qwert'}
    admin {true}
  end
  factory :test_user, class: User do
    name {'fukuoka'}
    email {'fukuoka@fukuoka.com'}
    password {'12345qwert'}
    password_confirmation {'12345qwert'}
  end
  factory :model_user, class: User do
    name {'taipei'}
    email {'taipei@taipei.com'}
    password {'12345qwert'}
    password_confirmation {'12345qwert'}
  end
  factory :super_user, class: User do
    name {'beijing'}
    email {'beijing@beijing.com'}
    password {'12345qwert'}
    password_confirmation {'12345qwert'}
  end
  factory :ultra_user, class: User do
    name {'tokushima'}
    email {'tokushima@tokushima.com'}
    password {'12345qwert'}
    password_confirmation {'12345qwert'}
  end
end
