require "./lib/classes/Summations"

class TestSummations < Test::Unit::TestCase
  def test_maneuver_creation

  end

  def test_db
    r = Summations.new

    # First we clear the table
    # r.resetDatabaseTable
    # assert_equal(0, r.getRowCount)

    # Then we populate it
    # r.createDatabaseTable
    # assert_equal(332, r.getRowCount)

    result = r.getSummationObjectFromDatabase('Song of Rage (1016)');

    re = result['name']
    assert_match('Song of Rage (1016)', result['effect_name'])
    # print result
  end
end


