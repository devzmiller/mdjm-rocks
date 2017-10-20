require 'rails_helper'

RSpec.describe Part, type: :model do
  let!(:part_example) { build(:part) }
  let!(:warehouse1) { create(:warehouse, name: "timbucktoo") }
  let!(:warehouse2) { create(:warehouse, name: "kalamazoo") }
  let!(:warehouse3) { create(:warehouse, name: "maryloo") }


  it 'is valid with a part_number, name, max_quantity' do
    expect(part_example).to be_valid
  end

  describe "it is invalid when it does not have" do
    it "a part_number" do
      part_example.part_number = nil
      expect(part_example).to_not be_valid
    end

    it "a name" do
      part_example.name = nil
      expect(part_example).to_not be_valid
    end

    it "max_quantity" do
      part_example.max_quantity = nil
      expect(part_example).to_not be_valid
    end
  end

  describe "associations" do
    it "has many warehouses" do
      part_example.warehouses << warehouse1
      expect(part_example.warehouses).to include warehouse1
    end

    it { should have_many(:orders) }
    it { should have_many(:orders_parts) }
  end

  describe '.overall_total' do
    it "returns total count of parts across warehouses" do
      stored_warehouses = [warehouse1, warehouse2, warehouse3]
      part_example.warehouses << stored_warehouses
      part_example.save
      expect(Part.overall_total(part_example)).to eq(stored_warehouses.length)
    end

    it 'returns 0 when part is not in any warehouses' do
      expect(Part.overall_total(part_example)).to eq(0)
    end
  end

  describe '.warehouse_total' do
    it 'returns total count of part in one warehouse' do
      part_example.warehouses << [warehouse1, warehouse2, warehouse1]
      part_example.save
      expect(Part.warehouse_total(warehouse1, part_example)).to eq(2)
    end
  end
end
