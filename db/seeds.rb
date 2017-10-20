require 'date'

 warehouses = []

10.times do
  Part.create(part_number: Faker::Number.number(5), name: Faker::Pokemon.move, max_quantity: 50)
  warehouses << Warehouse.create(name: Faker::Address.city)
end

3.times do
  part = Part.find 1
  warehouse = Warehouse.find 1
  warehouse.parts << part
end

3.times do
  user = User.create!(name: 'Jo Schmo', employee_num: Random.rand(500), password: 'cher', role: 'manager', warehouse: warehouses.sample)
  order = Order.create!(orderer: user, received_date: DateTime.now + 5, submitted: true)
  30.times do
    part = Part.create(part_number: Faker::Number.number(5), name: Faker::Pokemon.move, max_quantity: 50)
    OrdersPart.create(order: order, part: part, quantity_ordered: 13)
  end
end

User.create!(employee_num: 123, password: 'a', warehouse: warehouses.sample, name: "a", role: "manager")
