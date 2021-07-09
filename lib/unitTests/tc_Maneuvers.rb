require "./lib/classes/Maneuvers"

class TestManeuvers < Test::Unit::TestCase
  def test_maneuver_creation

  end

  def test_db
    r = Maneuvers.new

    # First we clear the table
    # r.resetDatabaseTable
    # assert_equal(0, r.getRowCount)

    # Then we populate it
    # r.createDatabaseTable
    # assert_equal(122, r.getRowCount)

    result = r.getManeuverObjectFromDatabase('Block the Elements');

    re = result['name']
    assert_match('Block the Elements', result['name'])
    # print result
  end
end


