FactoryGirl.define do
  factory :user, aliases: [:orderer] do
    name "Wilfred"
    sequence(:employee_num, 1000)
    password "password"
    role "manager"
  end
end
