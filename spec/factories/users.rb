FactoryBot.define do
  factory :user do
    name {'tokyo'}
    email {'tokyo7@tokyo.com'}
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
end
