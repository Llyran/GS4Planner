require "./lib/classes/Statistics"
# The Character object holds all the values and objects related to the character from across all the panels.
# These values can be easily accessed by all other panels and allows the planner to save and load character build file with minimum effort.
class Character

  def initialize
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

  def getPTP
    phsStats = getProfession[:prime]
    bonus = getRace()[:bonus]

    if (phsStats[:stat1] == 'Aura' || phsStats[:stat2] == 'Aura')
      aur = (@stats.getAur() * 2) + bonus.getAur()
    else
      aur = @stats.getAur() + bonus.getAur()
    end

    if (phsStats[:stat1] == 'Discipline' || phsStats[:stat2] == 'Discipline')
      dis = (@stats.getDis() * 2) + bonus.getDis()
    else
      dis = @stats.getDis() + bonus.getDis()
    end

    if (phsStats[:stat1] == 'Strength' || phsStats[:stat2] == 'Strength')
      str = (@stats.getStr() * 2) + bonus.getStr()
    else
      str = @stats.getStr() + bonus.getStr()
    end

    if (phsStats[:stat1] == 'Constitution' || phsStats[:stat2] == 'Constitution')
      con = (@stats.getCon() * 2) + bonus.getCon()
    else
      con = @stats.getCon() + bonus.getCon()
    end

    if (phsStats[:stat1] == 'Dexterity' || phsStats[:stat2] == 'Dexterity')
      dex = (@stats.getDex() * 2) + bonus.getDex()
    else
      dex = @stats.getDex() + bonus.getDex()
    end

    if (phsStats[:stat1] == 'Agility' || phsStats[:stat2] == 'Agility')
      agi = (@stats.getAgi() * 2) + bonus.getAgi()
    else
      agi = @stats.getAgi() + bonus.getAgi()
    end

    return 25 + ((((aur + dis) / 2) + str + con + dex + agi) / 20)
  end

  def getMTP
    menStats = getProfession[:mana]
    bonus = getRace()[:bonus]

    if (menStats[:stat1] == 'Aura' || menStats[:stat2] == 'Aura')
      aur = (@stats.getAur() * 2) + bonus.getAur()
    else
      aur = @stats.getAur() + bonus.getAur()
    end

    if (menStats[:stat1] == 'Discipline' || menStats[:stat2] == 'Discipline')
      dis = (@stats.getDis() * 2) + bonus.getDis()
    else
      dis = @stats.getDis() + bonus.getDis()
    end

    if (menStats[:stat1] == 'Logic' || menStats[:stat2] == 'Logic')
      log = (@stats.getLog() * 2) + bonus.getLog()
    else
      log = @stats.getLog() + bonus.getLog()
    end

    if (menStats[:stat1] == 'Intuition' || menStats[:stat2] == 'Intuition')
      int = (@stats.getInt() * 2) + bonus.getInt()
    else
      int = @stats.getInt() + bonus.getInt()
    end

    if (menStats[:stat1] == 'Wisdom' || menStats[:stat2] == 'Wisdom')
      wis = (@stats.getWis() * 2) + bonus.getWis()
    else
      wis = @stats.getWis() + bonus.getWis()
    end

    if (menStats[:stat1] == 'Influence' || menStats[:stat2] == 'Influence')
      inf = (@stats.getInf() * 2) + bonus.getInf()
    else
      inf = @stats.getInf() + bonus.getInf()
    end

    return 25 + ((((aur + dis) / 2) + log + inf + wis + inf) / 20)
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

  def loadCharacer

  end

  def saveCharacter

  end

  def update_statistics

  end

  def update_resources(level) end

  def is_prime_stat(stat) end

  def update_skills

  end

  def calculate_subskill_regained_tp(level, subskill_group) end

  def get_total_ranks_of_subskill(name, level, subskill_group) end

  def get_total_postcap_ranks_of_subskill(name, interval, subskill_group) end

  def update_maneuvers

  end

  def meets_maneuver_prerequisites(level, name, type) end

  def get_last_training_interval(experience, type, subtype) end
end





