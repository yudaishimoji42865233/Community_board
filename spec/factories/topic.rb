FactoryBot.define do
  factory :topic do
    content {"hello!"}
    image {"hoge.png"}
    category_id {1}
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    title { Faker::Internet.username(specifier: 3..8)}
    user
  end
end