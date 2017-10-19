FactoryGirl.define do
  factory :order do
    submitted true
    orderer initialize(:user)
  end
end
