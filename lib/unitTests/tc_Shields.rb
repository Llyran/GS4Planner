require "./lib/classes/Shields"

class TestShields < Test::Unit::TestCase
  def test_maneuver_creation

  end

  def test_db
    r = Shields.new

    # First we clear the table
    # r.resetDatabaseTable
    # assert_equal(0, r.getRowCount)

    # Then we populate it
    # r.createDatabaseTable
    # assert_equal(4, r.getRowCount)

    result = r.getShieldObjectFromDatabase('Medium Shield');

    re = result['name']
    assert_match('Medium Shield', result['name'])
    # print result
  end
end


