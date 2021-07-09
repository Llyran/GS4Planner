require "./lib/classes/Statistics"

class TestStatistics < Test::Unit::TestCase

  def test_creation_default
    s = Statistics.new

    assert_equal(0, s.getStr)
    assert_equal(0, s.getCon)
    assert_equal(0, s.getDex)
    assert_equal(0, s.getAgi)
    assert_equal(0, s.getDis)
    assert_equal(0, s.getAur)
    assert_equal(0, s.getLog)
    assert_equal(0, s.getInt)
    assert_equal(0, s.getWis)
    assert_equal(0, s.getInf)
  end

  def test_creation_hash
    s = Statistics.new
    hs = {
      str: 14, con: 17, dex: 31, agi: 32, dis: 45, aur: 52, log: 56, int: 63, wis: 64, inf: 77
    }
    s.setStatsFromHash(hs)

    assert_equal(14, s.getStr)
    assert_equal(17, s.getCon)
    assert_equal(31, s.getDex)
    assert_equal(32, s.getAgi)
    assert_equal(45, s.getDis)
    assert_equal(52, s.getAur)
    assert_equal(56, s.getLog)
    assert_equal(63, s.getInt)
    assert_equal(64, s.getWis)
    assert_equal(77, s.getInf)
  end

  def test_creation_name
    s = Statistics.new
    s.setStatsFromNames(str: 12, con:14, dex: 17, agi:19, dis:23, aur:27, log: 31, int:39, wis: 44, inf:51)

    assert_equal(12, s.getStr)
    assert_equal(14, s.getCon)
    assert_equal(17, s.getDex)
    assert_equal(19, s.getAgi)
    assert_equal(23, s.getDis)
    assert_equal(27, s.getAur)
    assert_equal(31, s.getLog)
    assert_equal(39, s.getInt)
    assert_equal(44, s.getWis)
    assert_equal(51, s.getInf)

    s.resetStats
    assert_equal(0, s.getStr)
    assert_equal(0, s.getCon)
    assert_equal(0, s.getDex)
    assert_equal(0, s.getAgi)
    assert_equal(0, s.getDis)
    assert_equal(0, s.getAur)
    assert_equal(0, s.getLog)
    assert_equal(0, s.getInt)
    assert_equal(0, s.getWis)
    assert_equal(0, s.getInf)

  end

  def test_individual_stats
    s = Statistics.new

    s.setStr(41)
    s.setCon(37)
    s.setDex(29)
    s.setAgi(51)
    s.setDis(72)
    s.setAur(87)
    s.setLog(99)
    s.setInt(37)
    s.setWis(86)
    s.setInf(69)

    assert_equal(41, s.getStr)
    assert_equal(37, s.getCon)
    assert_equal(29, s.getDex)
    assert_equal(51, s.getAgi)
    assert_equal(72, s.getDis)
    assert_equal(87, s.getAur)
    assert_equal(99, s.getLog)
    assert_equal(37, s.getInt)
    assert_equal(86, s.getWis)
    assert_equal(69, s.getInf)
  end
end
