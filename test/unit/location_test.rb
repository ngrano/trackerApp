require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should save location information" do
    palos_apteekki = Location.new

    palos_apteekki.longtitude = '63.108075'
    palos_apteekki.latitude = '21.593'

    assert palos_apteekki.save 
  end

  test "should not save location information without longtitude" do
    palos_apteekki = Location.new

    assert !palos_apteekki.valid?
    assert palos_apteekki.errors[:longtitude]
    assert !palos_apteekki.save
  end
end
