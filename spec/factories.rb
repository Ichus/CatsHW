FactoryGirl.define do
  factory :cat do
    sequence(:name) {|n| "Cat #{n}"}
    bio  'bio'
    breed  'breed'
    catchphrase  'catchphrase'
  end
end
