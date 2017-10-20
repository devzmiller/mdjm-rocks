FactoryGirl.define do
  factory :warehouse do
    name "Seattle"
  end

  factory :part do
    part_number 123456789
    name "cabbage launcher"
    max_quantity 50
  end

  factory :user do
    name "Wilfred"
    employee_num 12345
    password "password"
    warehouse
    role "manager"
    factory :non_manager do
      employee_num 67891
      role "scientist"
    end
  end



end
