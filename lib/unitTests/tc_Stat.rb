require "./lib/classes/Stat"

class TestStat < Test::Unit::TestCase

  def test_creation_default
    s = Stat.new('testName', 65, 17, 3)

    assert_equal('testName', s.getName, 'Failed Name')
    assert_equal(65, s.getBase, 'Failed Base')
    assert_equal(17, s.getGrowthStat,  'Failed Growth Stat')
  end

  def test_calc_growth
    s = Stat.new('testName', 65, 19, 2)
    growthResult = s.calcGrowth
    growthTest = [65,
    65,    65,    66,    66,    66,    67,    67,    67,    68,    68,
    68,    69,    69,    69,    70,    70,    70,    71,    71,    71,
    72,    72,    72,    73,    73,    73,    74,    74,    74,    75,
    75,    75,    76,    76,    76,    77,    77,    77,    77,    78,
    78,    78,    78,    79,    79,    79,    79,    80,    80,    80,
    80,    81,    81,    81,    81,    82,    82,    82,    82,    83,
    83,    83,    83,    84,    84,    84,    84,    85,    85,    85,
    85,    86,    86,    86,    86,    87,    87,    87,    87,    88,
    88,    88,    88,    89,    89,    89,    89,    90,    90,    90,
    90,    91,    91,    91,    91,    92,    92,    92,    92,    93]

    assert_equal(growthTest, growthResult, 'Failed internal growth calc test')
    assert_equal(growthTest, s.getStats, 'Failed growth stat retrieval')
    assert_equal(93, s.getStatsByIndex(100), 'Failed growth retrieval by index(100)')
    assert_equal(80, s.getStatsByIndex(50), 'Failed growth retrieval by index(50)')
  end

  def test_calc_growth2
    s = Stat.new('testName', 31, 32, -2)
    growthResult = s.calcGrowth

    growthTest = [31,
    32,    33,    34,    35,    36,    37,    38,    39,    40,    41,
    42,    43,    44,    45,    46,    47,    48,    49,    50,    51,
    52,    53,    54,    55,    56,    57,    58,    59,    60,    61,
    62,    63,    64,    65,    65,    66,    66,    67,    67,    68,
    68,    69,    69,    70,    70,    71,    71,    72,    72,    73,
    73,    74,    74,    75,    75,    76,    76,    77,    77,    78,
    78,    79,    79,    80,    80,    81,    81,    82,    82,    83,
    83,    84,    84,    85,    85,    86,    86,    87,    87,    88,
    88,    89,    89,    90,    90,    91,    91,    92,    92,    93,
    93,    94,    94,    95,    95,    96,    96,    96,    97,    97]

    assert_equal(growthTest, growthResult, 'Failed internal growth calc test')
    assert_equal(growthTest, s.getStats, 'Failed growth stat retrieval')
    assert_equal(97, s.getStatsByIndex(100), 'Failed growth retrieval by index(100)')
    assert_equal(73, s.getStatsByIndex(50), 'Failed growth retrieval by index(50)')
  end
end
