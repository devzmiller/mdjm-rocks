FactoryGirl.define do
  factory :user do
    name "Wilfred"
    employee_num 12345
    password "password"
    role "manager"
  end
  factory :order do
    submitted true
    # orderer FactoryGirl.create(:user)
    # receiver FactoryGirl.create(:user)
  end
end
