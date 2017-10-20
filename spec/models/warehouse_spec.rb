require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  let!(:warehouse_example) { Warehouse.new(name: 'Seattle') }

  it "is valid with a name" do
    expect(warehouse_example).to be_valid
  end

  it "is invalid without a name" do
    warehouse_example.name = ''
    expect(warehouse_example).to_not be_valid
  end

  describe "associations" do
    let!(:part_example) { Part.new(part_number: 12345, name: 'thruster', max_quantity: 10) }

    it "has many parts" do
      warehouse_example.parts << part_example
      expect(warehouse_example.parts).to include part_example
    end

    # it { should have_many(:users) }
  end
end
