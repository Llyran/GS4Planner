require "sqlite3"

class Armor
  DatabaseName = "./data/test.db"

  #constructor
  def initialize
    createDatabaseTable
  end

  # create SQLite3 table for races
  def createDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    # Creates the Armor table.
    db.execute "CREATE TABLE IF NOT EXISTS Armor (name, AG, ASG,  roundtime, action_penalty, normal_cva, magic_cva,  base_weight,  minor_spiritual_spell_hindrance, major_spiritual_spell_hindrance, cleric_spell_hindrance,   minor_elemental_spell_hindrance, minor_mental_spell_hindrance,  major_elemental_spell_hindrance, major_mental_spell_hindrance,  savant_spell_hindrance, ranger_spell_hindrance, sorcerer_spell_hindrance, wizard_spell_hindrance, bard_spell_hindrance, empath_spell_hindrance, paladin_spell_hindrance,  max_spell_hindrance, roundtime_train_off_ranks) "

    results = db.get_first_value "SELECT Count() from Armor";
    if results == 0
      # Cloth Armor	
      db.execute "INSERT INTO Armor VALUES('Clothing', 1, 1,  0, 0, 25, 20,  0,  0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 0) "
      db.execute "INSERT INTO Armor VALUES('Robes', 1, 2,  0, 0, 25, 15, 8,  0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 0) "

      # Soft Leather Armor	
      db.execute "INSERT INTO Armor VALUES('Light Leather', 2, 5,  0, 0, 20, 15, 10,  0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 0) "
      db.execute "INSERT INTO Armor VALUES('Full Leather', 2, 6,  1, 0, 19, 14, 13,  0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 2) "
      db.execute "INSERT INTO Armor VALUES('Reinforced Leather', 2, 7,  2, -5, 18, 13, 15,  0, 0, 0,  0, 0, 2, 2,  2, 0, 1, 2, 0, 0, 0,  4,6) "
      db.execute "INSERT INTO Armor VALUES('Double Leather', 2, 8,  2, -6, 17, 12, 16,  0, 0, 0,  0, 2, 4, 4,  4, 0, 2, 4, 2, 0, 0,  6, 6) "

      # Hard Leather Armor	
      db.execute "INSERT INTO Armor VALUES('Leather Breastplate', 3, 9,  3, -7, 11, 5, 16,  3, 4, 4,  4, 4, 6, 6,  6, 3, 5, 6, 3, 4, 2,  16, 10) "
      db.execute "INSERT INTO Armor VALUES('Cuirbouilli Leather', 3, 10,  4, -8, 10, 4, 17,  4, 5, 5,  5, 5, 7, 7,  7, 4, 6, 7, 3, 5, 3,  20, 15) "
      db.execute "INSERT INTO Armor VALUES('Studded Leather', 3, 11,  5, -10, 9, 3, 20,  5, 6, 6,  6, 6, 9, 9,  9, 5, 8, 9, 3, 6, 4,  24, 20) "
      db.execute "INSERT INTO Armor VALUES('Brigandine Armor', 3, 12,  6, -12, 8, 2, 25,  6, 7, 7,  7, 7, 12, 12,  12, 6, 11, 12, 7, 7, 5,  28, 27) "

      # Chain Armor	
      db.execute "INSERT INTO Armor VALUES('Chain Mail', 4, 13,  7, -13, 1, -6, 25,  7, 8, 8,  8, 8, 16, 16,  16, 7, 16, 16, 8, 8, 6,  40, 35) "
      db.execute "INSERT INTO Armor VALUES('Double Chain', 4, 14,  8, -14, 0, -7, 25,  8, 9, 9,  9, 9, 20, 20,  20, 8, 18, 20, 8, 9, 7,  45, 50) "
      db.execute "INSERT INTO Armor VALUES('Augmented Chain', 4, 15,  8, -16, -1, -8, 26,  9, 11, 11,  10, 10, 25, 25,  25, 9, 22, 25, 8, 11, 8,  55, 50) "
      db.execute "INSERT INTO Armor VALUES('Chain Hauberk', 4, 16,  9, -18, -2, -9, 27,  11, 14, 14,  12, 15, 30, 30,  30, 11, 26, 30, 15, 14, 9,  60, 70) "

      # Plate Armor	
      db.execute "INSERT INTO Armor VALUES('Metal Breastplate', 5, 17,  9, -20, -10, -18, 23,  16, 25, 25,  16, 21, 35, 35,  35, 21, 29, 35, 21, 25, 10,  90, 70) "
      db.execute "INSERT INTO Armor VALUES('Augmented Plate', 5, 18,  10, -25, -11, -19, 25,  17, 28, 28,  18, 21, 40, 40,  40, 24, 33, 40, 21, 28, 11,  92, 90) "
      db.execute "INSERT INTO Armor VALUES('Half Plate', 5, 19,  11, -30, -12, -20, 50,  18, 32, 32,  20, 21, 45, 45,  45, 27, 39, 45, 21, 32, 12,  94, 110) "
      db.execute "INSERT INTO Armor VALUES('Full Plate', 5, 20,  12, -35, -13, -21, 75,  20, 45, 45,  22, 50, 50, 50,  50, 30, 48, 50, 50, 45, 13,  96, 130) "
    end
  end

  # returns the number of rows in the races table.
  #   Used to see if we need to populate the table, and input for unit testing
  def getRowCount
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true
    db.get_first_value "SELECT Count() from Armor";
  end

  # truncates the races table
  #   Used primarily for unit testing
  def resetDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.execute "DELETE FROM Armor"
  end

  # Returns a hash based on the race passed in
  def getArmorObjectFromDatabase(name)
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    results = db.query "SELECT * from Armor where name=?", name
    result = results.next

    spell_hindrance = {
      minor_spiritual: result["minor_spiritual_spell_hindrance"], major_spiritual: result["major_spiritual_spell_hindrance"], cleric: result["cleric_spell_hindrance"],
      minor_elemental: result["minor_elemental_spell_hindrance"], minor_mental: result["minor_elemental_spell_hindrance"], major_elemental: result["major_elemental_spell_hindrance"],
      major_mental: result["major_mental_spell_hindrance"], savant: result["savant_spell_hindrance"], ranger: result["ranger_spell_hindrance"],
      sorcerer: result["sorcerer_spell_hindrance"], wizard: result["wizard_spell_hindrance"], bard: result["bard_spell_hindrance"], empath: result["empath_spell_hindrance"],
      paladin: result["paladin_spell_hindrance"], max: result["max_spell_hindrance"]
    }

    result.delete("minor_spiritual_spell_hindrance")
    result.delete("major_spiritual_spell_hindrance")
    result.delete("cleric_spell_hindrance")
    result.delete("minor_elemental_spell_hindrance")
    result.delete("minor_elemental_spell_hindrance")
    result.delete("major_elemental_spell_hindrance")
    result.delete("major_mental_spell_hindrance")
    result.delete("savant_spell_hindrance")
    result.delete("ranger_spell_hindrance")
    result.delete("sorcerer_spell_hindrance")
    result.delete("wizard_spell_hindrance")
    result.delete("bard_spell_hindrance")
    result.delete("empath_spell_hindrance")
    result.delete("paladin_spell_hindrance")
    result.delete("max_spell_hindrance")

    result.merge!(spell_hindrance: spell_hindrance)

    return result
  end


end
