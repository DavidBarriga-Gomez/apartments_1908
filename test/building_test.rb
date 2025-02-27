require './lib/renter'
require './lib/apartment'
require './lib/building'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class BuildingTest < Minitest::Test
  def setup
    @building = Building.new
    @a1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    @b2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    @spencer = Renter.new("Spencer")
    @jessie = Renter.new("Jessie")
  end

  def test_existence
    assert_instance_of Building, @building
  end

  def test_attributes
    assert_equal [], @building.units
  end

  def test_method_add_unit
    @building.add_unit(@a1)
    @building.add_unit(@b2)
    assert_equal [@a1, @b2], @building.units
  end

  def test_method_building_average_rent
    @building.add_unit(@a1)
    @building.add_unit(@b2)
    assert_equal 1099.5, @building.average_rent
  end

  def test_method_renter_with_highest_rent
    @b2.add_renter(@spencer)
    @building.add_unit(@a1)
    @building.add_unit(@b2)
    assert_equal @spencer, @building.renter_with_highest_rent
  end

  def test_method_annual_breakdown
    @b2.add_renter(@spencer)
    @building.add_unit(@a1)
    @building.add_unit(@b2)
    assert_equal ({"Spencer" => 11988}), @building.annual_breakdown
    @jessie = Renter.new("Jessie")
    @a1.add_renter(@jessie)
    assert_equal ({"Jessie" => 14400, "Spencer" => 11988}), @building.annual_breakdown
  end
end
