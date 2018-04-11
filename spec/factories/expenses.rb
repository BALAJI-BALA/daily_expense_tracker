# FactoryGirl.define do
#   factory :expense do
#     item     { Faker::Name.name }
#     date     { Faker::Time.between(DateTime.now - 1, DateTime.now) }
#     method   { Faker::Name.name }
#     amount   { Faker::Number.decimal(2) }
#     user_id  { Faker::Number.between(1, 2) }
#     category_id   { Faker::Number.between(1, 2) }
#   end
# end
