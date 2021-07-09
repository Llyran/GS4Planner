require "sqlite3"

class Shields
  def initialize
    @DatabaseName = './data/test.db'
    createDatabaseTable
  end

  def createDatabaseTable
    db = SQLite3::Database.open @DatabaseName
    db.results_as_hash = true

    # Creates the Shields table. Contains a list of all the shield types in the game
    db.execute "CREATE TABLE IF NOT EXISTS Shields (name, size, base_weight,  melee_size_modifer, ranged_size_modifer, ranged_size_bonus,  dodging_shield_factor, dodging_size_penalty ) "

    results = db.get_first_value "SELECT Count() from Shields";
    if results == 0
      db.execute "INSERT INTO Shields VALUES('Small Shield', 'small', 5,  0.85, 1.20, -8,  0.78, 0) "
      db.execute "INSERT INTO Shields VALUES('Medium Shield', 'medium', 8,  1.00, 1.50, 0,  0.70, 0) "
      db.execute "INSERT INTO Shields VALUES('Large Shield', 'large', 10,  1.15, 1.80, 8,  0.62, 5) "
      db.execute "INSERT INTO Shields VALUES('Tower Shield', 'tower', 12,  1.30, 2.10, 16,  0.54, 10) "
    end
  end

  # returns the number of rows in the races table.
  #   Used to see if we need to populate the table, and input for unit testing
  def getRowCount
    db = SQLite3::Database.open @DatabaseName
    db.results_as_hash = true
    db.get_first_value "SELECT Count() from Shields"
  end

  # truncates the races table
  #   Used primarily for unit testing
  def resetDatabaseTable
    db = SQLite3::Database.open @DatabaseName
    db.execute "DELETE FROM Shields"
  end

  # Returns a hash based on the race passed in
  def getShieldObjectFromDatabase(name)
    print name
    db = SQLite3::Database.open @DatabaseName
    db.results_as_hash = true

    results = db.query "SELECT * from Shields where name=?", name
    result = results.next
  end

end 
