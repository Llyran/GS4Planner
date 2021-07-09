require "./lib/classes/Skills"

class TestSkills < Test::Unit::TestCase
  def test_maneuver_creation

  end

  def test_db
    r = Skills.new

    # First we clear the table
    # r.resetDatabaseTable
    # assert_equal(0, r.getRowCount)

    # Then we populate it
    # r.createDatabaseTable
    # assert_equal(60, r.getRowCount)

    result = r.getSkillObjectFromDatabase('Harness Power');

    re = result['name']
    assert_match('Harness Power', result['name'])
    # print result
  end
end


