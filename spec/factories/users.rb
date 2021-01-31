FactoryBot.define do
  factory :user do
    name {'tokyo'}
    email {'tokyo@tokyo.com'}
    password {'12345qwert'}
    password_confirmation {'12345qwert'}
  end
  factory :second_user, class: User do
    name {'osaka'}
    email {'osaka@osaka.com'}
    password {'12345qwert'}
    password_confirmation {'12345qwert'}
  end
  factory :third_user, class: User do
    name {'nagoya'}
    email {'nagoya@nagoya.com'}
    password {'12345qwert'}
    password_confirmation {'12345qwert'}
  end
end
