require "sqlite3"
require "./lib/classes/Training"

class Skills
  DatabaseName = "./data/test.db"

  def initialize
    createDatabaseTable
  end

  def createDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    # Creates the Skills table. This includes the name, type, subskill, redux value, and PTP/MTP costs and max ranks per level for every profession.
    db.execute "CREATE TABLE IF NOT EXISTS Skills (name, type, subskill_group, redux_value)"

    results = db.get_first_value "SELECT Count() from Skills";
    if results == 0
      db.execute "INSERT INTO Skills VALUES ('Armor Use', 'armor', 'NONE', 0.4)"
      db.execute "INSERT INTO Skills VALUES ('Shield Use', 'armor', 'NONE', 0.4)"
      db.execute "INSERT INTO Skills VALUES ('Edged Weapons', 'weapon', 'NONE', 0.3)"
      db.execute "INSERT INTO Skills VALUES ('Blunt Weapons', 'weapon', 'NONE', 0.3)"
      db.execute "INSERT INTO Skills VALUES ('Two-Handed Weapons', 'weapon', 'NONE', 0.3)"
      db.execute "INSERT INTO Skills VALUES ('Ranged Weapons', 'weapon', 'NONE', 0.3)"
      db.execute "INSERT INTO Skills VALUES ('Thrown Weapons', 'weapon', 'NONE', 0.3)"
      db.execute "INSERT INTO Skills VALUES ('Polearm Weapons', 'weapon', 'NONE', 0.3)"
      db.execute "INSERT INTO Skills VALUES ('Brawling', 'weapon', 'NONE', 0.3)"
      db.execute "INSERT INTO Skills VALUES ('Ambush', 'combat', 'NONE', 0.4)"
      db.execute "INSERT INTO Skills VALUES ('Two Weapon Combat', 'combat', 'NONE', 0.4)"
      db.execute "INSERT INTO Skills VALUES ('Combat Maneuvers', 'combat', 'NONE', 0.4)"
      db.execute "INSERT INTO Skills VALUES ('Multi Opponent Combat', 'combat', 'NONE', 0.4)"
      db.execute "INSERT INTO Skills VALUES ('Physical Fitness', 'combat', 'NONE', 1)"
      db.execute "INSERT INTO Skills VALUES ('Dodging', 'combat', 'NONE', 0.4)"
      db.execute "INSERT INTO Skills VALUES ('Arcane Symbols', 'magic', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Magic Item Use', 'magic', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Aiming', 'magic', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Harness Power', 'magic', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Elemental Mana Control', 'magic', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Mental Mana Control', 'magic', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spiritual Mana Control', 'magic', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Minor Spiritual', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Major Spiritual', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Cleric', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Minor Elemental', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Major Elemental', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Ranger', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Sorcerer', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Wizard', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Bard', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Empath', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Savant', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Minor Mental', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Major Mental', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Paladin', 'magic', 'Spell Research', 0)"
      db.execute "INSERT INTO Skills VALUES ('Elemental Lore, Air', 'magic', 'Elemental Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Elemental Lore, Earth', 'magic', 'Elemental Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Elemental Lore, Fire', 'magic', 'Elemental Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Elemental Lore, Water', 'magic', 'Elemental Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spiritual Lore, Blessings', 'magic', 'Spiritual Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spiritual Lore, Religion', 'magic', 'Spiritual Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Spiritual Lore, Summoning', 'magic', 'Spiritual Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Sorcerous Lore, Demonology', 'magic', 'Sorcerous Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Sorcerous Lore, Necromancy', 'magic', 'Sorcerous Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Mental Lore, Divination', 'magic', 'Mental Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Mental Lore, Manipulation', 'magic', 'Mental Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Mental Lore, Telepathy', 'magic', 'Mental Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Mental Lore, Transference', 'magic', 'Mental Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Mental Lore, Transformation', 'magic', 'Mental Lore', 0)"
      db.execute "INSERT INTO Skills VALUES ('Survival', 'general', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Disarm Traps', 'general', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Picking Locks', 'general', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Stalking and Hiding', 'general', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Perception', 'general', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Climbing', 'general', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Swimming', 'general', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('First Aid', 'general', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Trading', 'general', 'NONE', 0)"
      db.execute "INSERT INTO Skills VALUES ('Pickpocketing', 'general', 'NONE', 0)"
    end
  end

  # returns the number of rows in the races table.
  #   Used to see if we need to populate the table, and input for unit testing
  def getRowCount
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true
    db.get_first_value "SELECT Count() from Skills";
  end

  # truncates the races table
  #   Used primarily for unit testing
  def resetDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.execute "DELETE FROM Skills"
  end

  # Returns a hash based on the race passed in
  def getSkillObjectFromDatabase(name)
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    results = db.query "SELECT * from Skills where name=?", name
    result = results.next

    bard = { ptp: result["bard_ptp"], mpt: result["bard_mpt"], max_ranks: result["bard_max_ranks"] }
    cleric = { ptp: result["cleric_ptp"], mpt: result["cleric_mpt"], max_ranks: result["cleric_max_ranks"] }
    empath = { ptp: result["empath_ptp"], mpt: result["empath_mpt"], max_ranks: result["empath_max_ranks"] }
    monk = { ptp: result["monk_ptp"], mpt: result["monk_mpt"], max_ranks: result["monk_max_ranks"] }
    paladin = { ptp: result["paladin_ptp"], mpt: result["paladin_mpt"], max_ranks: result["paladin_max_ranks"] }
    ranger = { ptp: result["ranger_ptp"], mpt: result["ranger_mpt"], max_ranks: result["ranger_max_ranks"] }
    rogue = { ptp: result["rogue_ptp"], mpt: result["rogue_mpt"], max_ranks: result["rogue_max_ranks"] }
    savant = { ptp: result["savant_ptp"], mpt: result["savant_mpt"], max_ranks: result["savant_max_ranks"] }
    sorcerer = { ptp: result["sorcerer_ptp"], mpt: result["sorcerer_mpt"], max_ranks: result["sorcerer_max_ranks"] }
    warrior = { ptp: result["warrior_ptp"], mpt: result["warrior_mpt"], max_ranks: result["warrior_max_ranks"] }
    wizard = { ptp: result["wizard_ptp"], mpt: result["wizard_mpt"], max_ranks: result["wizard_max_ranks"] }

    result.delete("bard_ptp")
    result.delete("bard_mtp")
    result.delete("bard_max_ranks")

    result.delete("cleric_ptp")
    result.delete("cleric_mtp")
    result.delete("cleric_max_ranks")

    result.delete("empath_ptp")
    result.delete("empath_mtp")
    result.delete("empath_max_ranks")

    result.delete("monk_ptp")
    result.delete("monk_mtp")
    result.delete("monk_max_ranks")

    result.delete("paladin_ptp")
    result.delete("paladin_mtp")
    result.delete("paladin_max_ranks")

    result.delete("ranger_ptp")
    result.delete("ranger_mtp")
    result.delete("ranger_max_ranks")

    result.delete("rogue_ptp")
    result.delete("rogue_mtp")
    result.delete("rogue_max_ranks")

    result.delete("savant_ptp")
    result.delete("savant_mtp")
    result.delete("savant_max_ranks")

    result.delete("sorcerer_ptp")
    result.delete("sorcerer_mtp")
    result.delete("sorcerer_max_ranks")

    result.delete("warrior_ptp")
    result.delete("warrior_mtp")
    result.delete("warrior_max_ranks")

    result.delete("wizard_ptp")
    result.delete("wizard_mtp")
    result.delete("wizard_max_ranks")

    result.merge!(bard: bard)
    result.merge!(cleric: cleric)
    result.merge!(empath: empath)
    result.merge!(monk: monk)
    result.merge!(paladin: paladin)
    result.merge!(ranger: ranger)
    result.merge!(rogue: rogue)
    result.merge!(savant: savant)
    result.merge!(sorcerer: sorcerer)
    result.merge!(warrior: warrior)
    result.merge!(wizard: wizard)
  end

  def getSkillsList(profession)
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true
    mySkills = []

    results = db.query "select Name from Skills JOIN Training on Skills.name = Training.skill AND Profession = ? ORDER BY type, subskill_group, name", profession
    results.each do |row|
      mySkills.push(row['name'])
    end

    return mySkills
  end

end