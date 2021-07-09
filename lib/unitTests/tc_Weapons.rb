require "./lib/classes/Weapons"

class TestWeapons < Test::Unit::TestCase
  def test_maneuver_creation

  end

  def test_db
    r = Weapons.new

    # First we clear the table
    # r.resetDatabaseTable
    # assert_equal(0, r.getRowCount)

    # Then we populate it
    # r.createDatabaseTable
    # assert_equal(84, r.getRowCount)

    result = r.getWeaponObjectFromDatabase('Runestaff');

    re = result['name']
    assert_match('Runestaff', result['name'])
    # print result
  end
end


