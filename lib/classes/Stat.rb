class Stat

  def initialize(name, base, growthStat, raceModifier)
    @name = name
    @base = base
    @growthStat = growthStat
    @raceModifier = raceModifier
    @growth = Array.new(101)
    @bonus = Array.new(101)
  end

  # Getters
  def getName
    @name
  end

  def getBase
    @base
  end

  def getGrowthStat
    @growthStat
  end

  def getStats
    @growth
  end

  def getStatsByIndex(idx)
    @growth[idx]
  end

  def getBonus
    @bonus
  end

  def getBonusByIndex(idx)
    @bonus[idx]
  end

  #setters
  def setGrowthStat(base)
    @base = base
    calcGrowth
  end

  def calcGrowth
    @growth[0] = @base
    @bonus[0] = ((@growth[0] - 50) / 2.0).truncate + @raceModifier

    # todo: This could need some debugging down the road..
    #   Plan to do extensive testing against calculator at url
    #   https://web.archive.org/web/20190605204233/https://gs4chart.cfapps.io/
    for i in 1..100
      myGrowth = (@growth[i - 1] / @growthStat).truncate
      myGrowth = (myGrowth <= 1) ? 1 : myGrowth

      @growth[i] = (i % myGrowth == 0) ? @growth[i - 1] + 1 : @growth[i - 1]
      @growth[i] = 100 if @growth[i] > 100

      @bonus[i] = ((@growth[i] - 50) / 2.0).truncate + @raceModifier
    end

    return {:growth => @growth, :bonus => @bonus}
  end

end
