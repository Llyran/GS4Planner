require "./lib/classes/Armor"

class TestArmor < Test::Unit::TestCase
  def test_armor_creation

  end

  def test_db
    r = Armor.new

    # First we clear the table
    # r.resetDatabaseTable
    # assert_equal(0, r.getRowCount)

    # Then we populate it
    # r.createDatabaseTable
    # assert_equal(18, r.getRowCount)

    result = r.getArmorObjectFromDatabase('Chain Mail');

    re = result['name']
    assert_match('Chain Mail', result['name'])
    # print result
  end
end
