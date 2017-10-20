FactoryGirl.define do
  factory :ordersPart do
    order
    part
    quantity_ordered 20
    quantity_received 18
  end
end
