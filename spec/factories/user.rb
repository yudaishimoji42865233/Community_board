FactoryBot.define do
  factory :user do
    password              {"00000000"}
    password_confirmation {"00000000"}
    sequence(:name) { Faker::Internet.username(specifier: 3..8)}
    sequence(:email) {Faker::Internet.email}
  end
end

