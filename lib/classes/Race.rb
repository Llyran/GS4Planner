# The Race object hold all the information for the character's current race.
require "sqlite3"
require "./lib/classes/Statistics"

class Race
  #constructor
  def initialize
    @DatabaseName = './data/test.db'
    createDatabaseTable
  end

  # Not unit tested
  def createRace(hs)
    @name = hs[:name]
    @manauever_bonus = hs[:manauever_bonus]
    @max_health = hs[:max_health]
    @health_regen = hs[:health_regen]
    @health_gain_rate = hs[:health_gain_rate]
    @spirit_regen_tier = hs[:spirit_regen_tier]
    @decay_timer = hs[:decay_timer]
    @encumbrance_factor = hs[:encumbrance_factor]
    @weight_factor = hs[:weight_factor]
    @elemental_td = hs[:elemental_td]
    @spiritual_td = hs[:spiritual_td]
    @mental_td = hs[:mental_td]
    @sorc_td = hs[:sorc_td]
    @poison_td = hs[:poison_td]
    @disease_td = hs[:disease_td]
    @statistic_bonus = ["Strength" => hs[:strength_bonus], "Constitution" => hs[:constitution_bonus],
                        "Dexterity" => hs[:dexterity_bonus], "Agility" => hs[:agility_bonus],
                        "Discipline" => hs[:discipline_bonus], "Aura" => hs[:aura_bonus],
                        "Logic" => hs[:logic_bonus], "Intuition" => hs[:intuition_bonus],
                        "Wisdom" => hs[:wisdom_bonus], "Influence" => hs[:influence_bonus]]
    @statistic_adj = ["Strength" => hs[:strength_adj], "Constitution" => hs[:constitution_adj],
                      "Dexterity" => hs[:dexterity_adj], "Agility" => hs[:agility_adj],
                      "Discipline" => hs[:discipline_adj], "Aura" => hs[:aura_adj],
                      "Logic" => hs[:logic_adj], "Intuition" => hs[:intuition_adj],
                      "Wisdom" => hs[:wisdom_adj], "Influence" => hs[:influence_adj]]

    # accessor methods

    # setter methods
  end

  # todo Need to convert this to pull races from database
  def getRaceList
    @raceNames = ["Aelotoi","Burghal Gnome","Dark Elf","Dwarf","Elf","Erithian","Forest Gnome","Giantman","Half Elf","Half Krolvin","Halfling","Human", "Sylvankind"]
  end

  # create SQLite3 table for races
  def createDatabaseTable
    db = SQLite3::Database.open @DatabaseName
    db.results_as_hash = true

    # Creates the Races table. This will contain all the known information about every race in GS4
    db.execute "CREATE TABLE IF NOT EXISTS Races (name, manauever_bonus, max_health, health_regen, health_gain_rate, spirit_regen_tier, decay_timer, encumbrance_factor, weight_factor, elemental_td, mental_td, spiritual_td, sorc_td, poison_td, disease_td, strength_bonus, constitution_bonus, dexterity_bonus, agility_bonus, discipline_bonus, aura_bonus, logic_bonus, intuition_bonus, wisdom_bonus, influence_bonus, strength_adj, constitution_adj, dexterity_adj, agility_adj, discipline_adj, aura_adj, logic_adj, intuition_adj, wisdom_adj, influence_adj)"

    results = db.get_first_value "SELECT Count() from races"
    if results == 0
      db.execute "INSERT INTO Races VALUES('Aelotoi', 'good', 120, 1, 5, 2, 10, 0.75, 0.68, 0, 0, 0, 0, 0, 0,  -5, 0, 5, 10, 5, 0, 5, 5, 0, -5,  0, -2, 3, 3, 2, 0, 0, 2, 0, -2) "
      db.execute "INSERT INTO Races VALUES('Burghal Gnome', 'best', 90, 2, 4, 3, 14, 0.4, 0.4, 0, 0, 0, 0, 0, 0,  -15, 10, 10, 10, -5, 5, 10, 5, 0, -5,  -5, 0, 3, 3, -3, -2, 5, 5, 0, 0) "
      db.execute "INSERT INTO Races VALUES('Dark Elf', 'good', 120, 1, 5, 1, 10, 0.78, 0.75, -5, 0, -5, -5, 10, 100,  0, -5, 10, 5, -10, 10, 0, 5, 5, -5,  0, -2, 5, 5, -2, 0, 0, 0, 0, 0) "
      db.execute "INSERT INTO Races VALUES('Dwarf', 'average', 140, 3, 6, 4, 16, 0.78, 0.75, 30, 0, 0, 15, 20, 15,  10, 15, 0, -5, 10, -10, 5, 0, 0, -10,  5, 5, -3, -5, 3, 0, 0, 0, 3, -2) "
      db.execute "INSERT INTO Races VALUES('Elf', 'excellent', 130, 1, 5, 1, 10, 0.70, 0.7, -5, 0, -5, -5, 10, 100,  0, 0, 5, 15, -15, 5, 0, 0, 0, 10,  0, -5, 5, 3, -5, 5, 0, 0, 0, 3) "
      db.execute "INSERT INTO Races VALUES('Erithian', 'good', 120, 1, 5, 2, 13, 0.72, 0.75, 0, 0, 0, 0, 0, 0,  -5, 10, 0, 0, 5, 0, 5, 0, 0, 10,  -2, 0, 0, 0, 3, 0, 2, 0, 0, 3) "
      db.execute "INSERT INTO Races VALUES('Forest Gnome', 'excellent', 100, 1, 4, 4, 16, 0.6, 0.48, 0, 0, 0, 0, 0, 0,  -10, 10, 5, 10, 5, 0, 5, 0, 5, -5,  -3, 2, 2, 3, 2, 0, 0, 0, 0, 0) "
      db.execute "INSERT INTO Races VALUES('Giantman', 'average', 200, 3, 7, 3, 13, 1.33, 1.2, -5, 0, 5, 0, 0, 0,  15, 10, -5, -5, 0, -5, -5, 0, 0, 5,  5, 3, -2, -2, 0, 0, 0, 2, 0, 0) "
      db.execute "INSERT INTO Races VALUES('Half Elf', 'good', 135, 2, 5, 2, 10, 0.92, 0.82, -5, 0, -5, -5, 0, 50,  0, 0, 5, 10, -5, 0, 0, 0, 0, 5,  2, 0, 2, 2, -2, 0, 0, 0, 0, 2) "
      db.execute "INSERT INTO Races VALUES('Half Krolvin', 'excellent', 165, 1, 6, 2, 13, 1.1, 1, 0, 0, 0, 0, 0, 0,  10, 10, 0, 5, 0, 0, -10, 0, -5, -5,  3, 5, 2, 2, 0, -2, -2, 0, 0, -2) "
      db.execute "INSERT INTO Races VALUES('Halfling', 'excellent', 100, 3, 4, 4, 16, 0.5, 0.45, 40, 0, 0, 20, 30, 30,  -15, 10, 15, 10, -5, -5, 5, 10, 0, -5,  -5, 5, 5, 5, -2, 0, -2, 0, 0, 0) "
      db.execute "INSERT INTO Races VALUES('Human', 'average', 150, 2, 6, 3, 14, 1, 0.9, 0, 0, 0, 0, 0, 0,  5, 0, 0, 0, 0, 0, 5, 5, 0, 0,  2, 2, 0, 0, 0, 0, 0, 2, 0, 0) "
      db.execute "INSERT INTO Races VALUES('Sylvankind', 'good', 130, 1, 5, 2, 10, 0.81, 0.72, -5, 0, -5, -5, 10, 100,  0, 0, 10, 5, -5, 5, 0, 0, 0, 0,  -3, -2, 5, 5, -5, 3, 0, 0, 0, 3) "
    end
  end

  # returns the number of rows in the races table.
  #   Used to see if we need to populate the table, and input for unit testing
  def getRowCount
    db = SQLite3::Database.open @DatabaseName
    db.results_as_hash = true
    db.get_first_value "SELECT Count() from races"
  end

  # truncates the races table
  #   Used primarily for unit testing
  def resetDatabaseTable
    db = SQLite3::Database.open @DatabaseName
    db.execute "DELETE FROM races"
  end

  # Returns a hash based on the race passed in
  def getRaceObjectFromDatabase(name)
    bonus = Statistics.new
    adjust = Statistics.new
    db = SQLite3::Database.open @DatabaseName
    db.results_as_hash = true

    results = db.query "SELECT * from races where name=?", name
    result = results.next

    td = { elemental: result['elemental_td'], mental: result['mental_td'], spiritual: result['spiritual_td'], sorc: result['sorc_td'], poison: result['poison_td'], disease: result['disease_td'] }

    result.delete('elemental_td')
    result.delete('mental_td')
    result.delete('spiritual_td')
    result.delete('sorc_td')
    result.delete('poison_td')
    result.delete('disease_td')

    bonus.setStr(result['strength_bonus'])
    bonus.setCon(result['constitution_bonus'])
    bonus.setDex(result['dexterity_bonus'])
    bonus.setAgi(result['agility_bonus'])
    bonus.setDis(result['discipline_bonus'])
    bonus.setAur(result['aura_bonus'])
    bonus.setLog(result['logic_bonus'])
    bonus.setInt(result['intuition_bonus'])
    bonus.setWis(result['wisdom_bonus'])
    bonus.setInf(result['influence_bonus'])

    adjust.setStr(result['strength_adj'])
    adjust.setCon(result['constitution_adj'])
    adjust.setDex(result['dexterity_adj'])
    adjust.setAgi(result['agility_adj'])
    adjust.setDis(result['discipline_adj'])
    adjust.setAur(result['aura_adj'])
    adjust.setLog(result['logic_adj'])
    adjust.setInt(result['intuition_adj'])
    adjust.setWis(result['wisdom_adj'])
    adjust.setInf(result['influence_adj'])

    result.delete('strength_adj')
    result.delete('constitution_adj')
    result.delete('dexterity_adj')
    result.delete('agility_adj')
    result.delete('discipline_adj')
    result.delete('aura_adj')
    result.delete('logic_adj')
    result.delete('intuition_adj')
    result.delete('wisdom_adj')
    result.delete('influence_adj')

    result.delete('strength_bonus')
    result.delete('constitution_bonus')
    result.delete('dexterity_bonus')
    result.delete('agility_bonus')
    result.delete('discipline_bonus')
    result.delete('aura_bonus')
    result.delete('logic_bonus')
    result.delete('intuition_bonus')
    result.delete('wisdom_bonus')
    result.delete('influence_bonus')

    result.merge!(td: td)
    result.merge!(bonus: bonus)
    result.merge!(adjust: adjust)
  end

end