require "./lib/classes/Effects"

class TestEffects < Test::Unit::TestCase
  def test_effect_creation

  end

  def test_db
    r = Effects.new

    # First we clear the table
    # r.resetDatabaseTable
    # assert_equal(0, r.getRowCount)

    # Then we populate it
    # r.createDatabaseTable
    # assert_equal(301, r.getRowCount)

    result = r.getEffectsObjectFromDatabase('Acuity AS Flare');

    re = result['name']
    assert_match('Acuity AS Flare', result['name'])
    # print result
  end
end

