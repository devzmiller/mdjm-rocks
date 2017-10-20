FactoryGirl.define do
  factory :user, aliases: [:orderer] do
    name "Wilfred"
    sequence(:employee_num, 1000)
    password "password"
    warehouse
    role "manager"
    factory :non_manager do
      role "scientist"
    end
  end
end
