require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should create user Niklas" do
    niklas = User.new

    niklas.first_name = 'Niklas'
    niklas.last_name = 'Grano'
    niklas.email = 'asdasd@gmail.com'
    niklas.password = 'heippa123'

    assert niklas.save
  end

  test "should not create user Simo without firstname and lastname" do
    simo = User.new

    simo.email = 'asdasdasd@gmail.com'
    simo.password = 'asdasdsadsad'

    assert !simo.save
  end

  test "should not create user Olli without a lastname" do
    olli = User.new
    
    olli.first_name = 'Olli'
    
    assert !olli.valid?
    assert olli.errors[:last_name]
  end
end
