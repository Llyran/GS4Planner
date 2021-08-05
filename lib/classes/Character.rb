require "./lib/classes/Statistics"
require "json"

# The Character object holds all the values and objects related to the character from across all the panels.
# These values can be easily accessed by all other panels and allows the planner to save and load character build file with minimum effort.
class Character
  DatabaseName = './data/test.db'

  def initialize
    createDatabaseTable

    @stats = Statistics.new
    @stats.createDefaultStats()
    # global statistics;
    @name = ""
    # Statistics Panel variables
    @race = ""
    @profession = ""

    # @race_list = {}; # Contains a list of Race objects using the name of each race name as a key
    # @profession_list = {}; # Contains a list of Profession objects using the name of each profession name as a key
    # @statistics_list = {}; # Contains a list of Statistic objects using the name of each statistic as a key
    # @racial_stat_bonus = {}; # Contains a list of bonuses for each statistic (calculted by race) using the name of each statistic as a key
    # @stat_adj = {}; # Contains a list of statistic adjustments (combination of race and profession growths) using the name of each statistic as a key
    #
    # Initialize the above variables
    # for stat in statistics :
    #   @statistics_list[stat] = Statistic(self, stat)
    #   @racial_stat_bonus[stat] = tkinter.IntVar()
    #   @stat_adj[stat] = tkinter.IntVar()
    # end
    # People like seeing the decimal form of their starting Training Point values when determining their starting stats. The rounded down value of each is using for the by_level variables
    # @ptp_base = tkinter.DoubleVar();
    # @mtp_base = tkinter.DoubleVar();
    # @statistic_totals_by_level = Array(0..100);
    # @ptp_by_level = Array(0..100);
    # @mtp_by_level = Array(0..100);
    # @total_ptp_by_level = Array(0..100);
    # @total_mtp_by_level = Array(0..100);

    # Resources are shown on the Statistics Panel but all of them need Skill build information to be calculated correctly.
    # @health_by_level = Array(0..100);
    # @mana_by_level = Array(0..100);
    # @stamina_by_level = Array(0..100);
    # @spirit_by_level = Array(0..100);

    # Misc Panel variables
    # @deity = tkinter.StringVar();
    # @elemental_attunement = tkinter.StringVar();
    # @society = tkinter.StringVar();
    # @society_rank = tkinter.StringVar();
    # @guild_skills_ranks = Array(0..5);
    # Skills Panel variables
    # @build_skills_list = []; # A list of Build_List_Skill objects that represent what the character wants to train in.
    # @skills_list = {}; # Hash of skill name -> Skill objects

    # Maneuvers Panel variables
    # Lists of Build_List_Skill objects that represent what the character wants to train in for each maneuver type
    # @combat_maneuvers_list = {};
    # @shield_maneuvers_list = {};
    # @armor_maneuvers_list = {};
    # Because their are different types of maneuvers, a seperate set of variables must be kept for each type: Combat, Shield, Armor
    # @build_combat_maneuvers_list = [];
    # @build_armor_maneuvers_list = [];
    # @build_shield_maneuvers_list = [];
    # Points for training in maneuvers are calculated as 1 point per rank in a specific skill. Combat -> Comabat Manevuers, Shield -> Shield Use, Armor -> Armor Use
    # @combat_points_by_level = Array(0..100);
    # @shield_points_by_level = Array(0..100);
    # @armor_points_by_level = Array(0..100);
    # @total_combat_points_by_level = Array(0..100);
    # @total_shield_points_by_level = Array(0..100);
    # @total_armor_points_by_level = Array(0..100);

    # Post Cap Panel variables
    # variables for build list
    # @postcap_build_skills_list = [];
    # @postcap_build_combat_maneuvers_list = [];
    # @postcap_build_armor_maneuvers_list = [];
    # @postcap_build_shield_maneuvers_list = [];
    # @postcap_skill_training_by_interval = collections.OrderedDict();
    # @postcap_total_skill_cost_by_interval = collections.OrderedDict(); # Includes both the PTP/MTP cost at a specific interval and the cumulative PTP/MTP cost for all intervals 	up to (and including) a specific interval
    # @postcap_TP_conversions_by_interval = collections.OrderedDict(); # Format A/B|C/D   A=PTP converted this interval, B=same as A but for MTP, C=Cumulative PTP converted at this interval including this interval, D=same as C but for MTP
    # @postcap_combat_training_by_interval = collections.OrderedDict();
    # @postcap_total_combat_cost_by_interval = collections.OrderedDict();
    # @postcap_shield_training_by_interval = collections.OrderedDict();
    # @postcap_total_shield_cost_by_interval = collections.OrderedDict();
    # @postcap_armor_training_by_interval = collections.OrderedDict();
    # @postcap_total_armor_cost_by_interval = collections.OrderedDict();

    # Loadout Panel variables
    # @loadout_gear_build_list = [];
    # @loadout_effects_build_list = [];

    # Progression Panel variables
    # @LdP_Gear_List_Updated = 0;
    # @LdP_Effects_List_Updated = 0;
  end

  def createDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    db.execute "CREATE TABLE IF NOT EXISTS Characters (name, jsonData)"
  end

  # Getters
  def getName
    @name
  end

  def getRace
    @race
  end

  def getProfession
    @profession
  end

  def getStats
    @stats
  end

  def isPrimeStat?(myStat)
    (myStat == @profession[:prime][:stat1] || myStat == @profession[:prime][:stat2])
  end

  def isManaStat?(myStat)
    (myStat == @profession[:mana][:stat1] || myStat == @profession[:mana][:stat2])
  end

  # Calculate PTP/MTP. This formula is (STR + CON + DEX + AGI) + (AUR + DIS) / 2  for PTP and (LOG + INT + WIS + INF) + (AUR + DIS) / 2 for MTP.
  # Prime statistics count as double for these calculations
  def getPtp_by_stats(myAur, myDis, myStr, myCon, myDex, myAgi)
    phsStats = getProfession[:prime]

    aur = (isPrimeStat?('Aura')) ? myAur * 2 : myAur
    dis = (isPrimeStat?('Discipline')) ? myDis * 2 : myDis
    str = (isPrimeStat?('Strength')) ? myStr * 2 : myStr
    con = (isPrimeStat?('Constitution')) ? myCon * 2 : myCon
    dex = (isPrimeStat?('Dexterity')) ? myDex * 2 : myDex
    agi = (isPrimeStat?('Agility')) ? myAgi * 2 : myAgi

    ptp_sum = (aur + dis) / 2
    ptp_sum = (ptp_sum + str + con + dex + agi) / 20
    ptp_sum += 25

    return ptp_sum
  end

  def getPTP
    ptp_sum = getPtp_by_stats(@stats.getAur(), @stats.getDis(), @stats.getStr(), @stats.getCon(), @stats.getDex(), @stats.getAgi())
    return ptp_sum
  end

  def getMtp_by_stats(myAur, myDis, myLog, myInt, myWis, myInf)
    menStats = getProfession[:mana]

    aur = (isManaStat?('Aura')) ? myAur * 2 : myAur
    dis = (isManaStat?('Discipline')) ? myDis * 2 : myDis
    log = (isManaStat?('Logic')) ? myLog * 2 : myLog
    int = (isManaStat?('Intuition')) ? myInt * 2 : myInt
    wis = (isManaStat?('Wisdom')) ? myWis * 2 : myWis
    inf = (isManaStat?('Influence')) ? myInf * 2 : myInf

    mtp_sum = (aur + dis) / 2
    mtp_sum = (mtp_sum + log + int + wis + inf) / 20
    mtp_sum += 25

    return mtp_sum
  end

  def getMTP
    mtp_sum = getPtp_by_stats(@stats.getAur(), @stats.getDis(), @stats.getLog(), @stats.getInt(), @stats.getWis(), @stats.getInf())
    return mtp_sum
  end

  def getExperienceByLevel(level)
    experience = [0, 25, 25, 50, 75, 100, 125, 150, 175, 200, 225, 250, 275, 300, 325, 350, 370, 390, 410, 430, 450, 470, 490, 510, 530, 550, #0..25
                  565, 580, 595, 610, 625, 640, 655, 670, 685, 700, 715, 730, 745, 760, 775, 785, 795, 805, 815, 825, 835, 845, 855, 865, 875, #26..50
                  880, 885, 890, 895, 900, 905, 910, 915, 920, 925, 930, 935, 940, 945, 950, 955, 960, 965, 970, 975, 980, 985, 990, 995, 1000, #51..75
                  1005, 1010, 1015, 1020, 1025, 1030, 1035, 1040, 1045, 1050, 1055, 1060, 1065, 1070, 1075, 1080, 1085, 1090, 1095, 1100, 1105, 1110, 1115, 1120, 1125] #76..100

    return experience[level] * 100
  end

  def getStatBonus(stat)
    # Bonus = ⌊(RawStat - 50)/2⌋ + RaceModifier
    my_stat = @stats.getStat(stat)
    race_modifier = getRace[:bonus].getStat(stat)
    bonus = ((my_stat - 50) / 2) + race_modifier

    return bonus
  end

  def calcHealth(level)
    base = []
    str = calcGrowth("str")
    con = calcGrowth("con")
    gain = { Aelotoi: 5, "Burgal Gnome": 4, "Dark Elf": 5, Dwarf: 6, Elf: 5, Erithian: 5, "Forest Gnome": 4,
             Giantman: 7, "Half Elf": 5, "Half Krolvin": 6, Halfling: 4, Human: 6, Sylviankind: 5 }
    (0..100).each do |i|
      base[i] = (str[i] + con[i]) / 10
    end

    return base
  end

  def calcMana(level)
    s1 = getStatBonus(@profession[:mana][:stat1])
    s2 = getStatBonus(@profession[:mana][:stat2])

    if (s1 > 0 && s2 > 0)
      return (s1 + s2) / 4
    else
      return s1 / 2
    end
  end

  def calcStamina(level)
    return 0
  end

  def calcSpirit()
    aur = []
    my_aur = calcGrowth("aur")
    (0..100).each do |i|
      aur[i] = (my_aur[i] / 10.0).round
    end

    return aur
  end

  def calcGrowth(stat)
    myStats = Array.new()

    myStart = @stats.getStat(stat)
    growth_interval = getGrowthIndex(stat)
    myStats[0] = myStart

    # todo: This could need some debugging down the road..
    #   Plan to do extensive testing against calculator at url
    #   https://web.archive.org/web/20190605204233/https://gs4chart.cfapps.io/
    for i in 1..100
      myGrowth = myStats[i - 1] / growth_interval
      myGrowth = (myGrowth <= 1) ? 1 : myGrowth

      myStats[i] = (i % myGrowth == 0) ? myStats[i - 1] + 1 : myStats[i - 1]
    end

    return myStats
  end

  def getGrowthIndex(stat)
    @profession[:growth].getStat(stat) + @race[:adjust].getStat(stat)
  end

  # Setters
  def setName(name)
    @name = name
  end

  def setRace(race_name)
    @race = race_name
  end

  def setProfession(profession_name)
    @profession = profession_name
  end

  # todo Need to figure out a storage mechanism.. either a DB or a flat file
  def loadCharacter(name)
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    results = db.query "select * from Characters where name = ?", name
    result = results.next

    mychar = JSON.parse(result['jsonData'])

    @name = mychar['name']
    @race = mychar['race']
    @profession = mychar['profession']

    mystats = mychar['stats']
    @stats.setStatsFromNames(:str => mystats['str'], :con => mystats['con'], :dex => mystats['dex'], :agi => mystats['agi'], :dis => mystats['dis'],
                             :aur => mystats['aur'], :log => mystats['log'], :int => mystats['int'], :wis => mystats['wis'], :inf => mystats['inf'])
  end

  # todo Need to figure out a storage mechanism.. either a DB or a flat file
  def saveCharacter(name)
    db = SQLite3::Database.open DatabaseName

    myDump = JSON.dump({ :name => @name, :race => @race['name'], :profession => @profession['name'], :stats => @stats.getStats })
    db.execute "insert into Characters VALUES (name, myDump) "
  end

  def getCharactersFromDb
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true
    myCharacters = []
    my_string = ""
    results = db.query "SELECT name from Characters"
    results.each do |row|
      myCharacters.push(row['name'])
      my_string += row['name'] + " "
    end

    return my_string
  end

  # def update_statistics()  end
  #
  # def update_resources(level) end
  #
  # def is_prime_stat(stat) end
  #
  # def update_skills() end
  #
  # def calculate_subskill_regained_tp(level, subskill_group) end
  #
  # def get_total_ranks_of_subskill(name, level, subskill_group) end
  #
  # def get_total_postcap_ranks_of_subskill(name, interval, subskill_group) end
  #
  # def update_maneuvers() end
  #
  # def meets_maneuver_prerequisites(level, name, type) end
  #
  # def get_last_training_interval(experience, type, subtype) end
end





