require "./lib/classes/Character"
require "./lib/classes/Profession"
require "./lib/classes/Race"

class TestCharacter < Test::Unit::TestCase

  def setup
    @race = Race.new
    @profession = Profession.new
    @character = Character.new

    @character.setName('Llyran')
    @character.setProfession(@profession.getProfessionObjectFromDatabase('Warrior'))
    @character.setRace(@race.getRaceObjectFromDatabase('Human'))
  end

  def test_setters_and_getters
    assert_equal('Llyran', @character.getName)
    assert_equal('Warrior', @character.getProfession['name'])
    assert_equal('Human', @character.getRace['name'])
    assert_equal(20, @character.getStats.getStr)
  end

  def test_stats_calls
    assert_equal(false, @character.isPrimeStat?('str'))
    assert_equal(true, @character.isPrimeStat?('Strength'))

    assert_equal(false, @character.isManaStat?('wis'))
    assert_equal(true, @character.isManaStat?('Wisdom'))
  end

  def test_ptp_mtp_calls
    assert_equal(32, @character.getPTP)
    assert_equal(32, @character.getMTP)
    assert_equal(52, @character.getPtp_by_stats(50,60,70,80,90,100))
    assert_equal(50, @character.getMtp_by_stats(50,60,70,80,90,100))
  end

  def test_experience
    assert_equal(55000, @character.getExperienceByLevel(25))
    assert_equal(112000, @character.getExperienceByLevel(99))
    assert_equal(112500, @character.getExperienceByLevel(100))
  end

  def test_growth
    assert_equal(40, @character.calcGrowth('str')[20])
    assert_equal(35, @character.calcGrowth('aur')[20])
  end

  def test_serialization
    # @character.saveCharacter
    @character.loadCharacter
  end
end
