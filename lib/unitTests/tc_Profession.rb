require "./lib/classes/Profession"

class TestProfession < Test::Unit::TestCase

  def test_profession_creation
    p = Profession.new
    p.createProfession(name: 'TestName', type: 'TestType', primeStats: {ps1: "logic", ps2: "strength"},
                       manaStats: {ms1: "logic", ms2: "aura"}, spellCircles: {sc1: "Minor Elemental", sc2: "bards circle", sc3: "none"},
                       guildSkills: {gs1: "1", gs2: "2", gs3: "3", gs4: "4", gs5: "5", gs6: "6"},
                       statGrowth: {str: 5, con: 10, dex: 15, agi: 20, dis: 25,
                                    aur: 30,log: 35, int: 40, wis: 45, inf: 50});

    assert_equal('TestName', p.getName)
    assert_equal('TestType', p.getType)
    assert_equal({ps1: 'logic', ps2: "strength"}, p.getPrimeStats)
    assert_equal({ms1: "logic", ms2: "aura"}, p.getManaStats)
    assert_equal({sc1: "Minor Elemental", sc2: "bards circle", sc3: "none"}, p.getSpellCircles)
    assert_equal({gs1: "1", gs2: "2", gs3: "3", gs4: "4", gs5: "5", gs6: "6"}, p.getGuildSkills)
    assert_equal({str: 5, con: 10, dex: 15, agi: 20, dis: 25, aur: 30,log: 35, int: 40, wis: 45, inf: 50}, p.getStatGrowth)
  end

  def test_db
    p = Profession.new

    # First we clear the table
    # p.resetDatabaseTable
    # assert_equal(0, p.getRowCount)

    # Then we populate it
    # p.createDatabaseTable
    # assert_equal(11, p.getRowCount)

    result = p.getProfessionObjectFromDatabase('Bard');

    re = result['name']
    assert_match('Bard', result['name'])
    # print result
  end
end