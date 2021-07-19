# The Profession object hold all the information for the character's current profession. This does not include skill costs or max ranks
require "sqlite3"
require "./lib/classes/Statistics"

class Profession
  DatabaseName = './data/test.db'

  #constructor
  def initialize
    # If the professions table doesn't exist, lets create it.
    createDatabaseTable
  end

  # Creates a profession object
  def createProfession(name:, type:, primeStats:, manaStats:, spellCircles:, guildSkills:, statGrowth:)
    @name = name;
    @type = type;

    #hashes
    @prime_statistics = primeStats
    @mana_statistics = manaStats
    @spell_circles = spellCircles
    @guild_skills = guildSkills
    @statistic_growth = statGrowth
  end

  # accessor methods
  # return the profession name
  def getName
    @name
  end

  # return the profession type [square|semi|pure]
  def getType
    @type
  end

  # returns the prime stats array
  def getPrimeStats
    @prime_statistics
  end

  # returns the two stats that affect mana
  def getManaStats
    @mana_statistics
  end

  # returns the 2 or 3 spell circles the professoin has access to
  def getSpellCircles
    @spell_circles
  end

  # returns a set of guild skills, if the class has an active guild
  def getGuildSkills
    @guild_skills
  end

  # returns a statsObject with the growth stats set
  def getStatGrowth
    @statistic_growth
  end

  # todo: Need to rewrite this to pull from database
  def getProfessionList
    @profNames = ["Bard", "Cleric", "Empath", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warrior", "Wizard"]
  end
  # setter methods

  # createDatabase table
  def createDatabaseTable

    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true
    db.execute "CREATE TABLE IF NOT EXISTS Professions (name, type,  prime_statistics1, prime_statistics2,  mana_statistic1,  mana_statistic2, spell_circle1, spell_circle2, spell_circle3, guild_skill1, guild_skill2, guild_skill3, guild_skill4, guild_skill5, guild_skill6,  strength_growth, constitution_growth, dexterity_growth, agility_growth, discipline_growth, aura_growth, logic_growth, intuition_growth, wisdom_growth, influence_growth)"
    results = db.get_first_value "SELECT Count() from professions";
    if results == 0
      db.execute "INSERT INTO Professions VALUES ('Bard', 'semi',  'Influence', 'Aura',  'Influence', 'Aura',  'Minor Elemental', 'Bard', 'NONE',  'NONE', 'NONE', 'NONE', 'NONE', 'NONE', 'NONE',  25, 20, 25, 20, 15, 25, 10, 15, 20, 30)"
      db.execute "INSERT INTO Professions VALUES ('Cleric', 'pure',  'Wisdom', 'Intuition',  'Wisdom', 'Wisdom',  'Minor Spiritual', 'Major Spiritual',  'Cleric', 'General Alchemy', 'Cleric Potions', 'Cleric Trinkets', 'NONE', 'NONE', 'NONE',   20, 20, 10, 15, 25, 15, 25, 25, 30, 20) "
      db.execute "INSERT INTO Professions VALUES ('Empath', 'pure',  'Wisdom', 'Influence',  'Wisdom', 'Influence',  'Minor Spiritual', 'Major Spiritual',  'Empath',  'General Alchemy', 'Empath Potions', 'Empath Trinkets', 'NONE', 'NONE', 'NONE',  10, 20, 15, 15, 25, 20, 25, 20, 30, 25) "
      db.execute "INSERT INTO Professions VALUES ('Monk', 'square',  'Agility', 'Strength',  'Wisdom', 'Logic',  'Minor Spiritual', 'Minor Mental', 'NONE',  'NONE', 'NONE', 'NONE', 'NONE', 'NONE', 'NONE',  25, 25, 20, 30, 25, 15, 20, 20, 15, 10) "
      db.execute "INSERT INTO Professions VALUES ('Paladin', 'semi',  'Wisdom', 'Strength',  'Wisdom', 'Wisdom',  'Minor Spiritual', 'Paladin', 'NONE',  'NONE', 'NONE', 'NONE', 'NONE', 'NONE', 'NONE',  30, 25, 20, 20, 25, 15, 10, 15, 25, 20) "
      db.execute "INSERT INTO Professions VALUES ('Ranger', 'semi',  'Dexterity', 'Intuition',  'Wisdom', 'Wisdom',  'Minor Spiritual', 'Ranger', 'NONE',  'NONE', 'NONE', 'NONE', 'NONE', 'NONE', 'NONE',  25, 20, 30, 20, 20, 15, 15, 25, 25, 10) "
      db.execute "INSERT INTO Professions VALUES ('Rogue', 'square',  'Dexterity', 'Agility',  'Aura', 'Wisdom',  'Minor Elemental', 'Minor Spiritual', 'NONE',  'Sweep', 'Subdue', 'Stun Maneuvers', 'Lock Mastery', 'Cheapshots', 'Rogue Gambits',  25, 20, 25, 30, 20, 15, 20, 25, 10, 15) "
      db.execute "INSERT INTO Professions VALUES ('Savant', 'pure',  'Influence', 'Logic',  'Influence', 'Influence',  'Minor Mental', 'Major Mental', 'Savant',  'General Alchemy', 'Savant Potions', 'Savant Trinkets', 'NONE', 'NONE', 'NONE',  0, 0, 0, 0, 0, 0, 0, 0, 0, 0) "
      db.execute "INSERT INTO Professions VALUES ('Sorcerer', 'pure',  'Aura', 'Wisdom',  'Aura', 'Wisdom',  'Minor Elemental', 'Minor Spiritual', 'Sorcerer',  'General Alchemy', 'Sorcerer Potions', 'Sorcerer Trinkets', 'Illusions', 'NONE', 'NONE',  10, 15, 20, 15, 25, 30, 25, 20, 25, 20) "
      db.execute "INSERT INTO Professions VALUES ('Warrior', 'square',  'Constitution', 'Strength',  'Aura', 'Wisdom',  'Minor Elemental', 'Minor Spiritual', 'NONE',  'Batter Barriers', 'Berserk', 'Disarm Weapon', 'Tackle', 'War Cries', 'Warrior Tricks',  30, 25, 25, 25, 20, 15, 10, 20, 15, 20) "
      db.execute "INSERT INTO Professions VALUES ('Wizard', 'pure',  'Aura', 'Logic',  'Aura', 'Aura',  'Minor Elemental', 'Major Elemental', 'Wizard',  'General Alchemy', 'Wizard Potions', 'Wizard Trinkets', 'NONE', 'NONE', 'NONE',  10, 15, 25, 15, 20, 30, 25, 25, 20, 20) "
    end
  end

  # returns the number of rows in the professions table.
  #   Used to see if we need to populate the table, and input for unit testing
  def getRowCount
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true
    db.get_first_value "SELECT Count() from professions";
  end

  # truncates the professions table
  #   Used primarily for unit testing
  def resetDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.execute "DELETE FROM professions"
  end

  # Returns a hash based on the profession passed in
  def getProfessionObjectFromDatabase(name)
    growth = Statistics.new
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    results = db.query "SELECT * from professions where name=?", name
    result = results.next

    spell_circles = { circle1: result['spell_circle1'], circle2: result['spell_circle2'], circle3: result['spell_circle3'] }

    result.delete('spell_circle1')
    result.delete('spell_circle2')
    result.delete('spell_circle3')

    prime = { stat1: result['prime_statistics1'], stat2: result['prime_statistics2'] }

    result.delete('prime_statistics1')
    result.delete('prime_statistics2')

    mana = { stat1: result['mana_statistic1'], stat2: result['mana_statistic2'] }

    result.delete('mana_statistic1')
    result.delete('mana_statistic2')

    growth.setStr(result['strength_growth'])
    growth.setCon(result['constitution_growth'])
    growth.setDex(result['dexterity_growth'])
    growth.setAgi(result['agility_growth'])
    growth.setDis(result['discipline_growth'])
    growth.setAur(result['aura_growth'])
    growth.setLog(result['logic_growth'])
    growth.setInt(result['intuition_growth'])
    growth.setWis(result['wisdom_growth'])
    growth.setInf(result['influence_growth'])

    result.delete('strength_growth')
    result.delete('constitution_growth')
    result.delete('dexterity_growth')
    result.delete('agility_growth')
    result.delete('discipline_growth')
    result.delete('aura_growth')
    result.delete('logic_growth')
    result.delete('intuition_growth')
    result.delete('wisdom_growth')
    result.delete('influence_growth')

    guild = { skill1: result['guild_skill1'], skill2: result['guild_skill2'], skill3: result['guild_skill3'], skill4: result['guild_skill4'], skill5: result['guild_skill5'], skill6: result['guild_skill6'] }
    result.delete('guild_skill1')
    result.delete('guild_skill2')
    result.delete('guild_skill3')
    result.delete('guild_skill4')
    result.delete('guild_skill5')
    result.delete('guild_skill6')

    result.merge!(spell_circles: spell_circles)
    result.merge!(prime: prime)
    result.merge!(mana: mana)
    result.merge!(growth: growth)
    result.merge!(guild: guild)
  end

end


