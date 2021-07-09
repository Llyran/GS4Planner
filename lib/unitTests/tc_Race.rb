require "./lib/classes/Race"

class TestRace < Test::Unit::TestCase
  def test_race_creation

  end

  def test_db
    r = Race.new

    # First we clear the table
    # r.resetDatabaseTable
    # assert_equal(0, r.getRowCount)

    # Then we populate it
    # r.createDatabaseTable
    # assert_equal(13, r.getRowCount)

    result = r.getRaceObjectFromDatabase('Sylvankind');

    re = result['name']
    assert_match('Sylvankind', result['name'])
    # print result
  end
end