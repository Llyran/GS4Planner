require "sqlite3"

class Training
  DatabaseName = "./data/test.db"

  def initialize()
    createDatabaseTable
  end

  def addTrainingSkill(skill_name, cost, goal, start, target, order)

    @skill_name = skill_name
    @goal = goal
    @cost = cost
    @start = start
    @target = target
    @order = order
  end

  def getTraining
    return { skill_name: @skill_name, goal: @goal, cost: @cost, start: @start, target: @target, order: @order }
  end
  def setName(name)
    @skill_name = name
  end

  def setGoal(goal)
    @goal = goal
  end

  def setCost(cost)
    @cost = cost
  end

  def setTraining(start, target)
    @start = start
    @target = target
  end

  def setOrder(order)
    @order = order
  end

  def getSkill
    @skill
  end

  def getName
    @skill_name
  end

  def getGoal
    @goal
  end

  def getCost
    @cost
  end

  def getStart
    @start
  end

  def getTarget
    @target
  end

  def getOrder
    @order
  end

  def getTrainingCost(skill, profession)
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    results = db.query "Select * from Training where skill = ? and profession = ?", skill, profession
    result = results.next

    return result
  end

  def createDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    db.execute "CREATE TABLE IF NOT EXISTS Training (skill, profession, ptp, mtp, ranks)"

    results = db.get_first_value "SELECT Count() from Training";
    if results == 0

      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Bard',  5,0,2)"
      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Cleric', 8,0,1)"
      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Empath',  15,0,1)"
      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Monk',  10,0,2)"
      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Paladin',  3,0,3)"
      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Ranger',  5,0,2)"
      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Rogue',  5,0,2)"
      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Savant',  15,0,1)"
      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Sorcerer',  15,0,1)"
      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Warrior',  2,0,3)"
      db.execute "INSERT INTO Training VALUES ('Armor Use', 'Wizard',  14,0,1)"

      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Bard',  5,0,2)"
      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Cleric',  13,0,1)"
      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Empath',  13,0,1)"
      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Monk',  8,0,2)"
      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Paladin',  3,0,2)"
      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Ranger',  5,0,2)"
      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Rogue',  4,0,2)"
      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Savant',  13,0,1)"
      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Sorcerer',  13,0,1)"
      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Warrior',  2,0,3)"
      db.execute "INSERT INTO Training VALUES ('Shield Use', 'Wizard',  13,0,1)"

      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Bard',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Cleric',  4,2,1)"
      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Empath',  6,2,1)"
      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Monk',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Paladin',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Ranger',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Rogue',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Savant',  6,2,1)"
      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Sorcerer',  6,2,1)"
      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Warrior',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Edged Weapons', 'Wizard',  6,1,1)"

      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Bard',  4,1,2)"
      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Cleric',  4,2,1)"
      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Empath',  6,2,1)"
      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Monk',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Paladin',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Ranger',  4,1,2)"
      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Rogue',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Savant',  6,2,1)"
      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Sorcerer',  6,2,1)"
      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Warrior',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Blunt Weapons', 'Wizard',  6,1,1)"

      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Bard', 7,2,2)"
      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Cleric',  10,3,1)"
      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Empath',  13,3,1)"
      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Monk',  5,2,2)"
      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Paladin',  4,2,2)"
      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Ranger',  6,2,2)"
      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Rogue',  6,2,2)"
      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Savant',  14,3,1)"
      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Sorcerer',  14,3,1)"
      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Warrior',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Two-Handed Weapons', 'Wizard',  14,3,1)"

      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Bard',  4,2,2)"
      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Cleric',  9,3,1)"
      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Empath',  14,3,1)"
      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Monk',  4,1,2)"
      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Paladin',  6,2,2)"
      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Ranger',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Rogue',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Savant',  14,3,1)"
      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Sorcerer',  14,3,1)"
      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Warrior',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Ranged Weapons', 'Wizard',  14,3,1)"

      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Bard',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Cleric',  9,3,1)"
      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Empath',  9,3,1)"
      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Monk',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Paladin',  5,2,2)"
      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Ranger',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Rogue',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Savant',  9,3,1)"
      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Sorcerer',  9,3,1)"
      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Warrior',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Thrown Weapons', 'Wizard',  8,2,1)"

      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Bard',  6,1,2)"
      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Cleric',  11,3,1)"
      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Empath',  14,3,1)"
      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Monk',  6,2,2)"
      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Paladin',  5,2,2)"
      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Ranger',  7,2,2)"
      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Rogue',  7,2,2)"
      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Savant',  14,3,1)"
      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Sorcerer',  14,3,1)"
      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Warrior',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Polearm Weapons', 'Wizard',  14,3,1)"

      db.execute "INSERT INTO Training VALUES ('Brawling', 'Bard',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Brawling', 'Cleric', 6,1,1)"
      db.execute "INSERT INTO Training VALUES ('Brawling', 'Empath',  10,2,1)"
      db.execute "INSERT INTO Training VALUES ('Brawling', 'Monk',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Brawling', 'Paladin',  4,1,2)"
      db.execute "INSERT INTO Training VALUES ('Brawling', 'Ranger',  4,2,2)"
      db.execute "INSERT INTO Training VALUES ('Brawling', 'Rogue',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Brawling', 'Savant',  10,2,1)"
      db.execute "INSERT INTO Training VALUES ('Brawling', 'Sorcerer',  10,2,1)"
      db.execute "INSERT INTO Training VALUES ('Brawling', 'Warrior',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Brawling', 'Wizard',  10,2,1)"

      db.execute "INSERT INTO Training VALUES ('Ambush', 'Bard',  4,4,1)"
      db.execute "INSERT INTO Training VALUES ('Ambush', 'Cleric',  12,12,1)"
      db.execute "INSERT INTO Training VALUES ('Ambush', 'Empath',  15,15,1)"
      db.execute "INSERT INTO Training VALUES ('Ambush', 'Monk',  3,2,2)"
      db.execute "INSERT INTO Training VALUES ('Ambush', 'Paladin',  4,5,1)"
      db.execute "INSERT INTO Training VALUES ('Ambush', 'Ranger',  3,3,2)"
      db.execute "INSERT INTO Training VALUES ('Ambush', 'Rogue',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Ambush', 'Savant',  15,15,1)"
      db.execute "INSERT INTO Training VALUES ('Ambush', 'Sorcerer',  15,14,1)"
      db.execute "INSERT INTO Training VALUES ('Ambush', 'Warrior',  3,4,2)"
      db.execute "INSERT INTO Training VALUES ('Ambush', 'Wizard',  15,10,1)"

      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Bard', 3,2,2)"
      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Cleric',  9,9,1)"
      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Empath',  12,12,1)"
      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Monk',  2,2,2)"
      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Paladin',  3,3,2)"
      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Ranger',  3,2,2)"
      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Rogue',  2,2,2)"
      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Savant',  12,12,1)"
      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Sorcerer',  12,12,1)"
      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Warrior',  2,2,2)"
      db.execute "INSERT INTO Training VALUES ('Two Weapon Combat', 'Wizard',  12,12,1)"

      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Bard',  8,4,2)"
      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Cleric',  10,6,1)"
      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Empath',  12,8,1)"
      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Monk',  5,3,2)"
      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Paladin',  5,4,2)"
      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Ranger',  6,4,2)"
      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Rogue',  4,4,2)"
      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Savant',  12,8,1)"
      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Sorcerer',  12,8,1)"
      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Warrior',  4,3,2)"
      db.execute "INSERT INTO Training VALUES ('Combat Maneuvers', 'Wizard',  12,8,1)"

      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Bard',  7,3,1)"
      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Cleric',  15,8,1)"
      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Empath',  15,10,1)"
      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Monk',  5,2,2)"
      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Paladin',  5,2,1)"
      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Ranger',  10,4,1)"
      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Rogue',  10,3,1)"
      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Savant',  15,10,1)"
      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Sorcerer',  15,10,1)"
      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Warrior',  4,3,2)"
      db.execute "INSERT INTO Training VALUES ('Multi Opponent Combat', 'Wizard',  15,10,1)"

      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Bard', 4,0,2)"
      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Cleric',  7,0,1)"
      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Empath',  2,0,3)"
      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Monk',  2,0,3)"
      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Paladin',  3,0,2)"
      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Ranger',  4,0,2)"
      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Rogue',  3,0,2)"
      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Savant',  8,0,1)"
      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Sorcerer',  8,0,1)"
      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Warrior',  2,0,3)"
      db.execute "INSERT INTO Training VALUES ('Physical Fitness', 'Wizard',  8,0,1)"

      db.execute "INSERT INTO Training VALUES ('Dodging', 'Bard',  6,6,2)"
      db.execute "INSERT INTO Training VALUES ('Dodging', 'Cleric',  20,20,1)"
      db.execute "INSERT INTO Training VALUES ('Dodging', 'Empath',  20,20,1)"
      db.execute "INSERT INTO Training VALUES ('Dodging', 'Monk',  1,1,3)"
      db.execute "INSERT INTO Training VALUES ('Dodging', 'Paladin',  5,3,2)"
      db.execute "INSERT INTO Training VALUES ('Dodging', 'Ranger',  7,5,2)"
      db.execute "INSERT INTO Training VALUES ('Dodging', 'Rogue',  2,1,3)"
      db.execute "INSERT INTO Training VALUES ('Dodging', 'Savant',  20,20,1)"
      db.execute "INSERT INTO Training VALUES ('Dodging', 'Sorcerer',  20,20,1)"
      db.execute "INSERT INTO Training VALUES ('Dodging', 'Warrior',  4,2,3)"
      db.execute "INSERT INTO Training VALUES ('Dodging', 'Wizard',  20,20,1)"

      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Bard',  0,4,2)"
      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Cleric',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Empath',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Monk',  0,6,1)"
      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Paladin',  0,5,1)"
      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Ranger',  0,5,1)"
      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Rogue',  0,7,1)"
      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Savant',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Sorcerer',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Warrior',  0,7,1)"
      db.execute "INSERT INTO Training VALUES ('Arcane Symbols', 'Wizard',  0,1,2)"

      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Bard',  0,4,2)"
      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Cleric',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Empath',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Monk',  0,7,1)"
      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Paladin',  0,6,1)"
      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Ranger',  0,5,1)"
      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Rogue',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Savant',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Sorcerer',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Warrior',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Magic Item Use', 'Wizard',  0,1,2)"

      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Bard',  3,10,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Cleric',  3,2,2)"
      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Empath',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Monk',  5,20,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Paladin',  5,20,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Ranger',  5,15,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Rogue',  4,22,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Savant',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Sorcerer',  3,1,2)"
      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Warrior',  5,25,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Aiming', 'Wizard',  2,1,2)"

      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Bard',  0,5,2)"
      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Cleric',  0,4,3)"
      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Empath',  0,4,3)"
      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Monk',  0,6,1)"
      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Paladin',  0,5,2)"
      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Ranger',  0,5,2)"
      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Rogue',  0,9,1)"
      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Savant',  0,4,3)"
      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Sorcerer',  0,4,3)"
      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Warrior',  0,10,1)"
      db.execute "INSERT INTO Training VALUES ('Harness Power', 'Wizard',  0,4,3)"

      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Bard',  0,6,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Cleric',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Empath',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Monk',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Paladin',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Ranger',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Rogue',  0,10,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Savant',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Sorcerer',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Warrior',  0,10,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Mana Control', 'Wizard',  0,4,2)"

      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Bard',  0,6,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Cleric',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Empath',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Monk',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Paladin',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Ranger',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Rogue',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Savant',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Sorcerer',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Warrior',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Mana Control', 'Wizard',  0,15,1)"

      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Bard',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Cleric',  0,3,3)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Empath',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Monk',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Paladin',  0,6,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Ranger',  0,5,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Rogue',  0,10,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Savant',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Sorcerer',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Warrior',  0,10,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Mana Control', 'Wizard',  0,15,1)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Spiritual', 'Cleric',  0,8,3)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Spiritual', 'Empath',  0,8,3)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Spiritual', 'Monk',  0,38,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Spiritual', 'Paladin',  0,27,2)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Spiritual', 'Ranger',  0,17,2)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Spiritual', 'Rogue',  0,67,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Spiritual', 'Sorcerer',  0,8,3)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Spiritual', 'Warrior',  0,120,1)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Major Spiritual', 'Cleric',  0,8,3)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Major Spiritual', 'Empath',  0,8,3)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Cleric', 'Cleric',  0,8,3)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Elemental', 'Bard',  0,17,2)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Elemental', 'Rogue',  0,67,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Elemental', 'Sorcerer',  0,8,3)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Elemental', 'Warrior',  0,120,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Elemental', 'Wizard',  0,8,3)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Major Elemental', 'Wizard',  0,8,3)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Ranger', 'Ranger',  0,17,2)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Sorcerer', 'Sorcerer',  0,8,3)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Wizard', 'Wizard',  0,8,3)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Bard', 'Bard',  0,17,2)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Empath', 'Empath',  0,8,3)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Savant', 'Savant',  0,8,3)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Mental', 'Monk',  0,38,1)"
      db.execute "INSERT INTO Training VALUES ('Spell Research, Minor Mental', 'Savant',  0,8,3)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Major Mental', 'Savant',  0,8,3)"

      db.execute "INSERT INTO Training VALUES ('Spell Research, Paladin', 'Paladin',  0,17,2)"

      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Bard',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Cleric',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Empath',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Monk',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Paladin',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Ranger',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Rogue',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Savant',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Sorcerer',  0,7,2)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Warrior',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Air', 'Wizard',  0,6,2)"

      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Bard',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Cleric',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Empath',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Monk',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Paladin',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Ranger',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Rogue',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Savant',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Sorcerer',  0,7,2)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Warrior',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Earth', 'Wizard',  0,6,2)"

      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Bard',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Cleric',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Empath',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Monk',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Paladin',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Ranger',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Rogue',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Savant',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Sorcerer',  0,7,2)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Warrior',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Fire', 'Wizard',  0,6,2)"

      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Bard',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Cleric',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Empath',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Monk',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Paladin',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Ranger',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Rogue',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Savant',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Sorcerer',  0,7,2)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Warrior',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Elemental Lore, Water', 'Wizard',  0,6,2)"

      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Bard',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Cleric',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Empath',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Monk',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Paladin',  0,7,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Ranger',  0,10,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Rogue',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Savant',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Sorcerer',  0,7,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Warrior',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Blessings', 'Wizard',  0,20,1)"

      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Bard',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Cleric',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Empath',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Monk',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Paladin',  0,7,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Ranger',  0,10,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Rogue',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Savant',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Sorcerer',  0,7,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Warrior',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Religion', 'Wizard',  0,20,1)"

      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Bard',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Cleric',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Empath',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Monk',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Paladin',  0,7,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Ranger',  0,10,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Rogue',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Savant',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Sorcerer',  0,7,2)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Warrior',  0,15,1)"
      db.execute "INSERT INTO Training VALUES ('Spiritual Lore, Summoning', 'Wizard',  0,20,1)"

      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Bard',  0,18,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Cleric',  0,10,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Empath',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Monk',  0,35,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Paladin',  0,18,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Ranger',  0,18,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Rogue',  0,30,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Savant',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Sorcerer',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Warrior',  0,30,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Demonology', 'Wizard',  0,10,1)"

      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Bard',  0,18,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Cleric',  0,10,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Empath',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Monk',  0,35,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Paladin',  0,18,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Ranger',  0,18,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Rogue',  0,30,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Savant',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Sorcerer',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Warrior',  0,30,1)"
      db.execute "INSERT INTO Training VALUES ('Sorcerous Lore, Necromancy', 'Wizard',  0,10,1)"

      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Bard',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Cleric',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Empath',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Monk',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Paladin',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Ranger',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Rogue',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Savant',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Sorcerer',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Warrior',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Divination', 'Wizard',  0,20,1)"

      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Bard',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Cleric',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Empath',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Monk',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Paladin',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Ranger',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Rogue',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Savant',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Sorcerer',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Warrior',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Manipulation', 'Wizard',  0,20,1)"

      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Bard',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Cleric',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Empath',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Monk',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Paladin',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Ranger',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Rogue',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Savant',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Sorcerer',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Warrior',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Telepathy', 'Wizard',  0,20,1)"

      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Bard',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Cleric',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Empath',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Monk',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Paladin',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Ranger',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Rogue',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Savant',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Sorcerer',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Warrior',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transference', 'Wizard',  0,20,1)"

      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Bard',  0,8,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Cleric',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Empath',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Monk',  0,12,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Paladin',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Ranger',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Rogue',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Savant',  0,6,2)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Sorcerer',  0,20,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Warrior',  0,40,1)"
      db.execute "INSERT INTO Training VALUES ('Mental Lore, Transformation', 'Wizard',  0,20,1)"

      db.execute "INSERT INTO Training VALUES ('Survival', 'Bard',  2,2,2)"
      db.execute "INSERT INTO Training VALUES ('Survival', 'Cleric',  3,2,2)"
      db.execute "INSERT INTO Training VALUES ('Survival', 'Empath',  3,2,2)"
      db.execute "INSERT INTO Training VALUES ('Survival', 'Monk',  2,2,2)"
      db.execute "INSERT INTO Training VALUES ('Survival', 'Paladin',  2,2,2)"
      db.execute "INSERT INTO Training VALUES ('Survival', 'Ranger',  1,1,2)"
      db.execute "INSERT INTO Training VALUES ('Survival', 'Rogue',  2,2,2)"
      db.execute "INSERT INTO Training VALUES ('Survival', 'Savant',  3,2,2)"
      db.execute "INSERT INTO Training VALUES ('Survival', 'Sorcerer',  3,2,1)"
      db.execute "INSERT INTO Training VALUES ('Survival', 'Warrior',  1,3,2)"
      db.execute "INSERT INTO Training VALUES ('Survival', 'Wizard',  3,2,2)"

      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Bard',  2,3,2)"
      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Cleric',  2,6,1)"
      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Empath',  2,6,1)"
      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Monk',  3,4,2)"
      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Paladin',  2,5,1)"
      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Ranger',  2,4,2)"
      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Rogue',  1,1,3)"
      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Savant',  2,6,1)"
      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Sorcerer',  2,6,1)"
      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Warrior',  2,4,2)"
      db.execute "INSERT INTO Training VALUES ('Disarm Traps', 'Wizard',  2,6,1)"

      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Bard',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Cleric',  2,4,2)"
      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Empath',  2,4,2)"
      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Monk',  3,3,2)"
      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Paladin',  2,4,2)"
      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Ranger',  2,3,2)"
      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Rogue',  1,1,3)"
      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Savant',  2,4,1)"
      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Sorcerer',  2,4,1)"
      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Warrior',  2,3,2)"
      db.execute "INSERT INTO Training VALUES ('Picking Locks', 'Wizard',  2,4,2)"

      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Bard',  3,2,2)"
      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Cleric',  5,4,1)"
      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Empath',  5,4,1)"
      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Monk',  3,2,2)"
      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Paladin',  4,4,1)"
      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Ranger',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Rogue',  1,1,3)"
      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Savant',  5,4,1)"
      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Sorcerer',  5,4,1)"
      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Warrior',  3,2,2)"
      db.execute "INSERT INTO Training VALUES ('Stalking and Hiding', 'Wizard',  5,4,1)"

      db.execute "INSERT INTO Training VALUES ('Perception', 'Bard',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Perception', 'Cleric',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Perception', 'Empath',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Perception', 'Monk',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Perception', 'Paladin',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Perception', 'Ranger',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Perception', 'Rogue',  0,1,3)"
      db.execute "INSERT INTO Training VALUES ('Perception', 'Savant',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Perception', 'Sorcerer',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Perception', 'Warrior',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Perception', 'Wizard',  0,3,2)"

      db.execute "INSERT INTO Training VALUES ('Climbing', 'Bard',  3,0,2)"
      db.execute "INSERT INTO Training VALUES ('Climbing', 'Cleric',  4,0,1)"
      db.execute "INSERT INTO Training VALUES ('Climbing', 'Empath',  4,0,1)"
      db.execute "INSERT INTO Training VALUES ('Climbing', 'Monk',  1,0,2)"
      db.execute "INSERT INTO Training VALUES ('Climbing', 'Paladin',  3,0,2)"
      db.execute "INSERT INTO Training VALUES ('Climbing', 'Ranger',  2,0,2)"
      db.execute "INSERT INTO Training VALUES ('Climbing', 'Rogue',  1,0,2)"
      db.execute "INSERT INTO Training VALUES ('Climbing', 'Savant',  4,0,1)"
      db.execute "INSERT INTO Training VALUES ('Climbing', 'Sorcerer',  4,0,1)"
      db.execute "INSERT INTO Training VALUES ('Climbing', 'Warrior',  3,0,2)"
      db.execute "INSERT INTO Training VALUES ('Climbing', 'Wizard',  4,0,1)"

      db.execute "INSERT INTO Training VALUES ('Swimming', 'Bard',  3,0,2)"
      db.execute "INSERT INTO Training VALUES ('Swimming', 'Cleric',  3,0,1)"
      db.execute "INSERT INTO Training VALUES ('Swimming', 'Empath',  3,0,1)"
      db.execute "INSERT INTO Training VALUES ('Swimming', 'Monk',  2,0,2)"
      db.execute "INSERT INTO Training VALUES ('Swimming', 'Paladin',  2,0,2)"
      db.execute "INSERT INTO Training VALUES ('Swimming', 'Ranger',  2,0,2)"
      db.execute "INSERT INTO Training VALUES ('Swimming', 'Rogue',  2,0,2)"
      db.execute "INSERT INTO Training VALUES ('Swimming', 'Savant',  3,0,1)"
      db.execute "INSERT INTO Training VALUES ('Swimming', 'Sorcerer',  3,0,1)"
      db.execute "INSERT INTO Training VALUES ('Swimming', 'Warrior',  2,0,2)"
      db.execute "INSERT INTO Training VALUES ('Swimming', 'Wizard',  3,0,1)"

      db.execute "INSERT INTO Training VALUES ('First Aid', 'Bard',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('First Aid', 'Cleric',  1,1,2)"
      db.execute "INSERT INTO Training VALUES ('First Aid', 'Empath',  1,0,3)"
      db.execute "INSERT INTO Training VALUES ('First Aid', 'Monk',  1,2,2)"
      db.execute "INSERT INTO Training VALUES ('First Aid', 'Paladin',  1,1,2)"
      db.execute "INSERT INTO Training VALUES ('First Aid', 'Ranger',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('First Aid', 'Rogue',  1,2,2)"
      db.execute "INSERT INTO Training VALUES ('First Aid', 'Savant',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('First Aid', 'Sorcerer',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('First Aid', 'Warrior',  1,2,2)"
      db.execute "INSERT INTO Training VALUES ('First Aid', 'Wizard',  2,1,2)"

      db.execute "INSERT INTO Training VALUES ('Trading', 'Bard',  0,2,2)"
      db.execute "INSERT INTO Training VALUES ('Trading', 'Cleric',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Trading', 'Empath',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Trading', 'Monk',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Trading', 'Paladin',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Trading', 'Ranger',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Trading', 'Rogue',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Trading', 'Savant',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Trading', 'Sorcerer',  0,3,2)"
      db.execute "INSERT INTO Training VALUES ('Trading', 'Warrior',  0,4,2)"
      db.execute "INSERT INTO Training VALUES ('Trading', 'Wizard',  0,3,2)"

      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Bard',  2,1,2)"
      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Cleric',  3,3,1)"
      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Empath',  3,3,1)"
      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Monk',  2,2,2)"
      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Paladin',  4,4,1)"
      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Ranger',  2,3,1)"
      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Rogue',  1,0,2)"
      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Savant',  3,3,1)"
      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Sorcerer',  3,3,1)"
      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Warrior',  2,3,1)"
      db.execute "INSERT INTO Training VALUES ('Pickpocketing', 'Wizard',  3,3,1)"
    end
  end
end