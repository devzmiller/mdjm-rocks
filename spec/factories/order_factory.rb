FactoryGirl.define do
  factory :order do
    submitted false
    orderer
    warehouse
  end
end
