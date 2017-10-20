FactoryGirl.define do
  factory :warehouse do
    name "Seattle"
  end

  factory :part do
    part_number 123456789
    name "cabbage launcher"
    max_quantity 50
  end
end
