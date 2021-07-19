class Statistics

  def initialize
    createStats
  end

  def createStats
    @str = 0
    @con = 0
    @dex = 0
    @agi = 0
    @dis = 0
    @aur = 0
    @log = 0
    @int = 0
    @wis = 0
    @inf = 0
  end

  def createDefaultStats
    @str = 20
    @con = 20
    @dex = 20
    @agi = 20
    @dis = 20
    @aur = 20
    @log = 20
    @int = 20
    @wis = 20
    @inf = 20
  end

  #Setters
  def setStr(val)
    @str = val
  end

  def setCon(val)
    @con = val
  end

  def setDex(val)
    @dex = val
  end

  def setAgi(val)
    @agi = val
  end

  def setDis(val)
    @dis = val
  end

  def setAur(val)
    @aur = val
  end

  def setLog(val)
    @log = val
  end

  def setInt(val)
    @int = val
  end

  def setWis(val)
    @wis = val
  end

  def setInf(val)
    @inf = val
  end

  def setStatsFromHash(hs)
    @str = hs[:str]
    @con = hs[:con]
    @dex = hs[:dex]
    @agi = hs[:agi]
    @dis = hs[:dis]
    @aur = hs[:aur]
    @log = hs[:log]
    @int = hs[:int]
    @wis = hs[:wis]
    @inf = hs[:inf]
  end

  def setStatsFromNames(str:, con:, dex:, agi:, dis:, aur:, log:, int:, wis:, inf:)
    @str = str
    @con = con
    @dex = dex
    @agi = agi
    @dis = dis
    @aur = aur
    @log = log
    @int = int
    @wis = wis
    @inf = inf
  end

  #Getters
  def getStr
    @str
  end

  def getCon
    @con
  end

  def getDex
    @dex
  end

  def getAgi
    @agi
  end

  def getDis
    @dis
  end

  def getAur
    @aur
  end

  def getLog
    @log
  end

  def getInt
    @int
  end

  def getWis
    @wis
  end

  def getInf
    @inf
  end

  def getStatNames
    return {str: "Strength", con: "Constitution", dex: "Dexterity", agi: "Agility", dis: "Discipline",
                  aur: "Aura", log: "Logic", int: "Intuition", wis: "Wisdom", inf: "Influence"}
  end

  def getStats
    {str: @str, con: @con, dex: @dex, agi: @agi, dis: @dis,
     aur: @aur, log: @log, int: @int, wis: @wis, inf: @inf}
  end

  def getStat(stat)
    case stat
    when "str"
      return getStr
    when "con"
      return getCon
    when "dex"
      return getDex
    when "agi"
      return getAgi
    when "dis"
      return getDis
    when "aur"
      return getAur
    when "log"
      return getLog
    when "int"
      return getInt
    when "wis"
      return getWis
    when "inf"
      return getInf
    end
  end

  def setStat(stat, value)
    case stat
    when "str"
      return setStr(value)
    when "con"
      return setCon(value)
    when "dex"
      return setDex(value)
    when "agi"
      return setAgi(value)
    when "dis"
      return setDis(value)
    when "aur"
      return setAur(value)
    when "log"
      return setLog(value)
    when "int"
      return setInt(value)
    when "wis"
      return setWis(value)
    when "inf"
      return setInf(value)
    end
  end

  def resetStats
    createStats
  end

  def getStatTotal
    return @str + @con + @dex + @agi + @dis + @aur + @log + @int + @wis + @inf
  end

end