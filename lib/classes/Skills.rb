require "sqlite3"

class Skills
  def initialize
    @DatabaseName = './data/test.db'
    createDatabaseTable
  end

  def createDatabaseTable
    db = SQLite3::Database.open @DatabaseName
    db.results_as_hash = true

    # Creates the Skills table. This includes the name, type, subskill, redux value, and PTP/MTP costs and max ranks per level for every profession.
    db.execute "CREATE TABLE IF NOT EXISTS Skills (name, type, subskill_group, redux_value, bard_ptp, bard_mtp, bard_max_ranks, cleric_ptp, cleric_mtp, cleric_max_ranks, empath_ptp, empath_mtp, empath_max_ranks, monk_ptp, monk_mtp, monk_max_ranks, paladin_ptp, paladin_mtp, paladin_max_ranks, ranger_ptp, ranger_mtp, ranger_max_ranks, rogue_ptp, rogue_mtp, rogue_max_ranks, savant_ptp, savant_mtp, savant_max_ranks, sorcerer_ptp, sorcerer_mtp, sorcerer_max_ranks, warrior_ptp, warrior_mtp, warrior_max_ranks, wizard_ptp, wizard_mtp, wizard_max_ranks) "

    results = db.get_first_value "SELECT Count() from Skills";
    if results == 0
      db.execute "INSERT INTO Skills VALUES ('Armor Use', 'armor', 'NONE', 0.4,  5,0,2,  8,0,1,  15,0,1,  10,0,2,  3,0,3,  5,0,2,  5,0,2,  15,0,1,  15,0,1,  2,0,3,  14,0,1) "
      db.execute "INSERT INTO Skills VALUES ('Shield Use', 'armor', 'NONE', 0.4,  5,0,2,  13,0,1,  13,0,1,  8,0,2,  3,0,2,  5,0,2,  4,0,2,  13,0,1,  13,0,1,  2,0,3,  13,0,1) "
      db.execute "INSERT INTO Skills VALUES ('Edged Weapons', 'weapon', 'NONE', 0.3,  3,1,2,  4,2,1,  6,2,1,  2,1,2,  3,1,2,  3,1,2,  2,1,2,  6,2,1,  6,2,1,  2,1,2,  6,1,1) "
      db.execute "INSERT INTO Skills VALUES ('Blunt Weapons', 'weapon', 'NONE', 0.3,  4,1,2,  4,2,1,  6,2,1,  3,1,2,  3,1,2,  4,1,2,  3,1,2,  6,2,1,  6,2,1,  2,1,2,  6,1,1) "
      db.execute "INSERT INTO Skills VALUES ('Two-Handed Weapons', 'weapon', 'NONE', 0.3,  7,2,2,  10,3,1,  13,3,1,  5,2,2,  4,2,2,  6,2,2,  6,2,2,  14,3,1,  14,3,1,  3,1,2,  14,3,1) "
      db.execute "INSERT INTO Skills VALUES ('Ranged Weapons', 'weapon', 'NONE', 0.3,  4,2,2,  9,3,1,  14,3,1,  4,1,2,  6,2,2,  3,1,2,  3,1,2,  14,3,1,  14,3,1,  2,1,2,  14,3,1) "
      db.execute "INSERT INTO Skills VALUES ('Thrown Weapons', 'weapon', 'NONE', 0.3,  3,1,2,  9,3,1,  9,3,1,  2,1,2,  5,2,2,  2,1,2,  2,1,2,  9,3,1,  9,3,1,  2,1,2,  8,2,1) "
      db.execute "INSERT INTO Skills VALUES ('Polearm Weapons', 'weapon', 'NONE', 0.3,  6,1,2,  11,3,1,  14,3,1,  6,2,2,  5,2,2,  7,2,2,  7,2,2,  14,3,1,  14,3,1,  3,1,2,  14,3,1) "
      db.execute "INSERT INTO Skills VALUES ('Brawling', 'weapon', 'NONE', 0.3,  3,1,2,  6,1,1,  10,2,1,  2,1,2,  4,1,2,  4,2,2,  3,1,2,  10,2,1,  10,2,1,  2,1,2,  10,2,1) "
      db.execute "INSERT INTO Skills VALUES ('Ambush', 'combat', 'NONE', 0.4,  4,4,1,  12,12,1,  15,15,1,  3,2,2,  4,5,1,  3,3,2,  2,1,2,  15,15,1,  15,14,1,  3,4,2,  15,10,1) "
      db.execute "INSERT INTO Skills VALUES ('Two Weapon Combat', 'combat', 'NONE', 0.4,  3,2,2,  9,9,1,  12,12,1,  2,2,2,  3,3,2,  3,2,2,  2,2,2,  12,12,1,  12,12,1,  2,2,2,  12,12,1) "
      db.execute "INSERT INTO Skills VALUES ('Combat Maneuvers', 'combat', 'NONE', 0.4,  8,4,2,  10,6,1,  12,8,1,  5,3,2,  5,4,2,  6,4,2,  4,4,2,  12,8,1,  12,8,1,  4,3,2,  12,8,1) "
      db.execute "INSERT INTO Skills VALUES ('Multi Opponent Combat', 'combat', 'NONE', 0.4,  7,3,1,  15,8,1,  15,10,1,  5,2,2,  5,2,1,  10,4,1,  10,3,1,  15,10,1,  15,10,1,  4,3,2,  15,10,1) "
      db.execute "INSERT INTO Skills VALUES ('Physical Fitness', 'combat', 'NONE', 1,  4,0,2,  7,0,1,  2,0,3,  2,0,3,  3,0,2,  4,0,2,  3,0,2,  8,0,1,  8,0,1,  2,0,3,  8,0,1) "
      db.execute "INSERT INTO Skills VALUES ('Dodging', 'combat', 'NONE', 0.4,  6,6,2,  20,20,1,  20,20,1,  1,1,3,  5,3,2,  7,5,2,  2,1,3,  20,20,1,  20,20,1,  4,2,3,  20,20,1) "
      db.execute "INSERT INTO Skills VALUES ('Arcane Symbols', 'magic', 'NONE', 0,  0,4,2,  0,2,2,  0,2,2,  0,6,1,  0,5,1,  0,5,1,  0,7,1,  0,2,2,  0,2,2,  0,7,1,  0,1,2) "
      db.execute "INSERT INTO Skills VALUES ('Magic Item Use', 'magic', 'NONE', 0,  0,4,2,  0,2,2,  0,2,2,  0,7,1,  0,6,1,  0,5,1,  0,8,1,  0,2,2,  0,2,2,  0,8,1,  0,1,2) "
      db.execute "INSERT INTO Skills VALUES ('Spell Aiming', 'magic', 'NONE', 0,  3,10,1,  3,2,2,  3,1,2,  5,20,1,  5,20,1,  5,15,1,  4,22,1,  3,1,2,  3,1,2,  5,25,1,  2,1,2) "
      db.execute "INSERT INTO Skills VALUES ('Harness Power', 'magic', 'NONE', 0,  0,5,2,  0,4,3,  0,4,3,  0,6,1,  0,5,2,  0,5,2,  0,9,1,  0,4,3,  0,4,3,  0,10,1,  0,4,3) "
      db.execute "INSERT INTO Skills VALUES ('Elemental Mana Control', 'magic', 'NONE', 0,  0,6,1,  0,12,1,  0,12,1,  0,15,1,  0,15,1,  0,15,1,  0,10,1,  0,3,2,  0,3,2,  0,10,1,  0,4,2) "
      db.execute "INSERT INTO Skills VALUES ('Mental Mana Control', 'magic', 'NONE', 0,  0,6,1,  0,12,1,  0,3,2,  0,8,1,  0,15,1,  0,15,1,  0,15,1,  0,3,2,  0,12,1,  0,15,1,  0,15,1) "
      db.execute "INSERT INTO Skills VALUES ('Spiritual Mana Control', 'magic', 'NONE', 0,  0,12,1,  0,3,3,  0,3,2,  0,8,1,  0,6,1,  0,5,1,  0,10,1,  0,12,1,  0,3,2,  0,10,1,  0,15,1) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Minor Spiritual', 'magic', 'Spell Research', 0,  0,0,0,  0,8,3,  0,8,3,  0,38,1,  0,27,2,  0,17,2,  0,67,1,  0,0,0,  0,8,3,  0,120,1,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Major Spiritual', 'magic', 'Spell Research', 0,  0,0,0,  0,8,3,  0,8,3,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Cleric', 'magic', 'Spell Research', 0,  0,0,0,  0,8,3,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Minor Elemental', 'magic', 'Spell Research', 0,  0,17,2,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,67,1,  0,0,0,  0,8,3,  0,120,1,  0,8,3) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Major Elemental', 'magic', 'Spell Research', 0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,8,3) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Ranger', 'magic', 'Spell Research', 0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,17,2,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Sorcerer', 'magic', 'Spell Research', 0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,8,3,  0,0,0,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Wizard', 'magic', 'Spell Research', 0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,8,3) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Bard', 'magic', 'Spell Research', 0,  0,17,2,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Empath', 'magic', 'Spell Research', 0,  0,0,0,  0,0,0,  0,8,3,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Savant', 'magic', 'Spell Research', 0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,8,3,  0,0,0,  0,0,0,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Minor Mental', 'magic', 'Spell Research', 0,  0,0,0,  0,0,0,  0,0,0,  0,38,1,  0,0,0,  0,0,0,  0,0,0,  0,8,3,  0,0,0,  0,0,0,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Major Mental', 'magic', 'Spell Research', 0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,8,3,  0,0,0,  0,0,0,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Spell Research, Paladin', 'magic', 'Spell Research', 0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,17,2,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0,  0,0,0) "
      db.execute "INSERT INTO Skills VALUES ('Elemental Lore, Air', 'magic', 'Elemental Lore', 0,  0,8,1,  0,20,1,  0,20,1,  0,40,1,  0,20,1,  0,20,1,  0,15,1,  0,20,1,  0,7,2,  0,15,1,  0,6,2) "
      db.execute "INSERT INTO Skills VALUES ('Elemental Lore, Earth', 'magic', 'Elemental Lore', 0,  0,8,1,  0,20,1,  0,20,1,  0,40,1,  0,20,1,  0,20,1,  0,15,1,  0,20,1,  0,7,2,  0,15,1,  0,6,2) "
      db.execute "INSERT INTO Skills VALUES ('Elemental Lore, Fire', 'magic', 'Elemental Lore', 0,  0,8,1,  0,20,1,  0,20,1,  0,40,1,  0,20,1,  0,20,1,  0,15,1,  0,20,1,  0,7,2,  0,15,1,  0,6,2) "
      db.execute "INSERT INTO Skills VALUES ('Elemental Lore, Water', 'magic', 'Elemental Lore', 0,  0,8,1,  0,20,1,  0,20,1,  0,40,1,  0,20,1,  0,20,1,  0,15,1,  0,20,1,  0,7,2,  0,15,1,  0,6,2) "
      db.execute "INSERT INTO Skills VALUES ('Spiritual Lore, Blessings', 'magic', 'Spiritual Lore', 0,  0,20,1,  0,6,2,  0,6,2,  0,12,1,  0,7,2,  0,10,1,  0,15,1,  0,20,1,  0,7,2,  0,15,1,  0,20,1) "
      db.execute "INSERT INTO Skills VALUES ('Spiritual Lore, Religion', 'magic', 'Spiritual Lore', 0,  0,20,1,  0,6,2,  0,6,2,  0,12,1,  0,7,2,  0,10,1,  0,15,1,  0,20,1,  0,7,2,  0,15,1,  0,20,1) "
      db.execute "INSERT INTO Skills VALUES ('Spiritual Lore, Summoning', 'magic', 'Spiritual Lore', 0,  0,20,1,  0,6,2,  0,6,2,  0,12,1,  0,7,2,  0,10,1,  0,15,1,  0,20,1,  0,7,2,  0,15,1,  0,20,1) "
      db.execute "INSERT INTO Skills VALUES ('Sorcerous Lore, Demonology', 'magic', 'Sorcerous Lore', 0,  0,18,1,  0,10,1,  0,12,1,  0,35,1,  0,18,1,  0,18,1,  0,30,1,  0,12,1,  0,6,2,  0,30,1,  0,10,1) "
      db.execute "INSERT INTO Skills VALUES ('Sorcerous Lore, Necromancy', 'magic', 'Sorcerous Lore', 0,  0,18,1,  0,10,1,  0,12,1,  0,35,1,  0,18,1,  0,18,1,  0,30,1,  0,12,1,  0,6,2,  0,30,1,  0,10,1) "
      db.execute "INSERT INTO Skills VALUES ('Mental Lore, Divination', 'magic', 'Mental Lore', 0,  0,8,1,  0,20,1,  0,6,2,  0,12,1,  0,20,1,  0,20,1,  0,40,1,  0,6,2,  0,20,1,  0,40,1,  0,20,1) "
      db.execute "INSERT INTO Skills VALUES ('Mental Lore, Manipulation', 'magic', 'Mental Lore', 0,  0,8,1,  0,20,1,  0,6,2,  0,12,1,  0,20,1,  0,20,1,  0,40,1,  0,6,2,  0,20,1,  0,40,1,  0,20,1) "
      db.execute "INSERT INTO Skills VALUES ('Mental Lore, Telepathy', 'magic', 'Mental Lore', 0,  0,8,1,  0,20,1,  0,6,2,  0,12,1,  0,20,1,  0,20,1,  0,40,1,  0,6,2,  0,20,1,  0,40,1,  0,20,1) "
      db.execute "INSERT INTO Skills VALUES ('Mental Lore, Transference', 'magic', 'Mental Lore', 0,  0,8,1,  0,20,1,  0,6,2,  0,12,1,  0,20,1,  0,20,1,  0,40,1,  0,6,2,  0,20,1,  0,40,1,  0,20,1) "
      db.execute "INSERT INTO Skills VALUES ('Mental Lore, Transformation', 'magic', 'Mental Lore', 0,  0,8,1,  0,20,1,  0,6,2,  0,12,1,  0,20,1,  0,20,1,  0,40,1,  0,6,2,  0,20,1,  0,40,1,  0,20,1) "
      db.execute "INSERT INTO Skills VALUES ('Survival', 'general', 'NONE', 0,  2,2,2,  3,2,2,  3,2,2,  2,2,2,  2,2,2,  1,1,2,  2,2,2,  3,2,2,  3,2,1,  1,3,2,  3,2,2) "
      db.execute "INSERT INTO Skills VALUES ('Disarm Traps', 'general', 'NONE', 0,  2,3,2,  2,6,1,  2,6,1,  3,4,2,  2,5,1,  2,4,2,  1,1,3,  2,6,1,  2,6,1,  2,4,2,  2,6,1) "
      db.execute "INSERT INTO Skills VALUES ('Picking Locks', 'general', 'NONE', 0,  2,1,2,  2,4,2,  2,4,2,  3,3,2,  2,4,2,  2,3,2,  1,1,3,  2,4,1,  2,4,1,  2,3,2,  2,4,2) "
      db.execute "INSERT INTO Skills VALUES ('Stalking and Hiding', 'general', 'NONE', 0,  3,2,2,  5,4,1,  5,4,1,  3,2,2,  4,4,1,  2,1,2,  1,1,3,  5,4,1,  5,4,1,  3,2,2,  5,4,1) "
      db.execute "INSERT INTO Skills VALUES ('Perception', 'general', 'NONE', 0,  0,3,2,  0,3,2,  0,3,2,  0,2,2,  0,3,2,  0,2,2,  0,1,3,  0,3,2,  0,3,2,  0,3,2,  0,3,2) "
      db.execute "INSERT INTO Skills VALUES ('Climbing', 'general', 'NONE', 0,  3,0,2,  4,0,1,  4,0,1,  1,0,2,  3,0,2,  2,0,2,  1,0,2,  4,0,1,  4,0,1,  3,0,2,  4,0,1) "
      db.execute "INSERT INTO Skills VALUES ('Swimming', 'general', 'NONE', 0,  3,0,2,  3,0,1,  3,0,1,  2,0,2,  2,0,2,  2,0,2,  2,0,2,  3,0,1,  3,0,1,  2,0,2,  3,0,1) "
      db.execute "INSERT INTO Skills VALUES ('First Aid', 'general', 'NONE', 0,  2,1,2,  1,1,2,  1,0,3,  1,2,2,  1,1,2,  2,1,2,  1,2,2,  2,1,2,  2,1,2,  1,2,2,  2,1,2) "
      db.execute "INSERT INTO Skills VALUES ('Trading', 'general', 'NONE', 0,  0,2,2,  0,3,2,  0,3,2,  0,3,2,  0,3,2,  0,3,2,  0,3,2,  0,3,2,  0,3,2,  0,4,2,  0,3,2) "
      db.execute "INSERT INTO Skills VALUES ('Pickpocketing', 'general', 'NONE', 0,  2,1,2,  3,3,1,  3,3,1,  2,2,2,  4,4,1,  2,3,1,  1,0,2,  3,3,1,  3,3,1,  2,3,1,  3,3,1) "
    end
  end

  # returns the number of rows in the races table.
  #   Used to see if we need to populate the table, and input for unit testing
  def getRowCount
    db = SQLite3::Database.open @DatabaseName
    db.results_as_hash = true
    db.get_first_value "SELECT Count() from Skills";
  end

  # truncates the races table
  #   Used primarily for unit testing
  def resetDatabaseTable
    db = SQLite3::Database.open @DatabaseName
    db.execute "DELETE FROM Skills"
  end

  # Returns a hash based on the race passed in
  def getSkillObjectFromDatabase(name)
    db = SQLite3::Database.open @DatabaseName
    db.results_as_hash = true

    results = db.query "SELECT * from Skills where name=?", name
    result = results.next

    bard = {ptp: result['bard_ptp'], mpt: result['bard_mpt'], max_ranks: result['bard_max_ranks']}
    cleric = {ptp: result['cleric_ptp'], mpt: result['cleric_mpt'], max_ranks: result['cleric_max_ranks']}
    empath = {ptp: result['empath_ptp'], mpt: result['empath_mpt'], max_ranks: result['empath_max_ranks']}
    monk = {ptp: result['monk_ptp'], mpt: result['monk_mpt'], max_ranks: result['monk_max_ranks']}
    paladin = {ptp: result['paladin_ptp'], mpt: result['paladin_mpt'], max_ranks: result['paladin_max_ranks']}
    ranger = {ptp: result['ranger_ptp'], mpt: result['ranger_mpt'], max_ranks: result['ranger_max_ranks']}
    rogue = {ptp: result['rogue_ptp'], mpt: result['rogue_mpt'], max_ranks: result['rogue_max_ranks']}
    savant  = {ptp: result['savant_ptp'], mpt: result['savant_mpt'], max_ranks: result['savant_max_ranks']}
    sorcerer = {ptp: result['sorcerer_ptp'], mpt: result['sorcerer_mpt'], max_ranks: result['sorcerer_max_ranks']}
    warrior = {ptp: result['warrior_ptp'], mpt: result['warrior_mpt'], max_ranks: result['warrior_max_ranks']}
    wizard = {ptp: result['wizard_ptp'], mpt: result['wizard_mpt'], max_ranks: result['wizard_max_ranks']}

    result.delete('bard_ptp')
    result.delete('bard_mtp')
    result.delete('bard_max_ranks')

    result.delete('cleric_ptp')
    result.delete('cleric_mtp')
    result.delete('cleric_max_ranks')

    result.delete('empath_ptp')
    result.delete('empath_mtp')
    result.delete('empath_max_ranks')

    result.delete('monk_ptp')
    result.delete('monk_mtp')
    result.delete('monk_max_ranks')

    result.delete('paladin_ptp')
    result.delete('paladin_mtp')
    result.delete('paladin_max_ranks')

    result.delete('ranger_ptp')
    result.delete('ranger_mtp')
    result.delete('ranger_max_ranks')

    result.delete('rogue_ptp')
    result.delete('rogue_mtp')
    result.delete('rogue_max_ranks')

    result.delete('savant_ptp')
    result.delete('savant_mtp')
    result.delete('savant_max_ranks')

    result.delete('sorcerer_ptp')
    result.delete('sorcerer_mtp')
    result.delete('sorcerer_max_ranks')

    result.delete('warrior_ptp')
    result.delete('warrior_mtp')
    result.delete('warrior_max_ranks')

    result.delete('wizard_ptp')
    result.delete('wizard_mtp')
    result.delete('wizard_max_ranks')

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

end