require "sqlite3"

class Maneuvers
  DatabaseName = './data/test.db'

  #constructor
  def initialize
    createDatabaseTable
  end

  # create SQLite3 table for races
  def createDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    # Creates the Maneuvers table. This table contains every Combat Maneuver, Shield Maneuver, and Armor Specializion. The base costs, profession availability, and prerequisites are also in this table.
    db.execute "CREATE TABLE IF NOT EXISTS Maneuvers (name, mnemonic, type, ranks, cost_rank1, cost_rank2, cost_rank3, cost_rank4, cost_rank5, available_bard, available_cleric, available_empath, available_monk, available_paladin, available_ranger, available_rogue, available_savant, available_sorcerer, available_warrior, available_wizard, prerequisites)"

    results = db.get_first_value "SELECT Count() from Maneuvers"
    if results == 0
      db.execute "INSERT INTO Maneuvers VALUES ('Armor Spike Focus', 'SPIKEFOCUS', 'combat', 2,  5, 10, 'NONE', 'NONE', 'NONE',  0,0,0,0,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Bearhug', 'BEARHUG', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Berserk', 'BERSERK', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Block Mastery', 'BMASTERY', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Bull Rush', 'BULLRUSH', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Burst of Swiftness', 'BURST', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,0,0,0,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Charge', 'CHARGE', 'combat', 5,  2, 4, 6, 8, 10,  1,0,0,1,1,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Cheapshots', 'CHEAPSHOTS', 'combat', 5,  2, 3, 4, 5, 6,  1,0,0,1,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Combat Focus', 'FOCUS', 'combat', 5,  2, 4, 6, 8, 10,  1,0,0,1,1,1,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Combat Mastery', 'CMASTERY', 'combat', 2,  2, 4, 'NONE', 'NONE', 'NONE',  1,1,1,1,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Combat Mobility', 'MOBILITY', 'combat', 2,  5, 10, 'NONE', 'NONE', 'NONE',  0,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Combat Movement', 'CMOVEMENT', 'combat', 5,  2, 3, 4, 5, 6,  1,1,1,1,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Combat Toughness', 'TOUGHNESS', 'combat', 3,  6, 8, 10, 'NONE', 'NONE',  0,0,0,1,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Coup de Grace', 'COUPDEGRACE', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Crowd Press', 'CPRESS', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Cunning Defense', 'CDEFENSE', 'combat', 5,  2, 3, 4, 5, 6,  1,1,1,1,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Cutthroat', 'CUTTROAT', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Dirtkick', 'DIRTKICK', 'combat', 5,  2, 3, 4, 5, 6,  1,1,1,1,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Disarm Weapon', 'DISARM', 'combat', 5,  2, 4, 6, 8, 10,  1,1,1,1,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Divert', 'DIVERT', 'combat', 5,  2, 3, 4, 5, 6,  0,0,0,0,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Duck and Weave', 'WEAVE', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,1,0,0,1,0,0,0,0, 'CM:Combat Movement:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Dust Shroud', 'SSHROUD', 'combat', 5,  2, 3, 4, 5, 6,  0,0,0,0,0,0,1,0,0,0,0, 'CM:Dirtkick:5') "
      db.execute "INSERT INTO Maneuvers VALUES ('Evade Mastery', 'EMSATERY', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES (\"Executioner's Stance\", 'EXECUTIONER', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Feint', 'FEINT', 'combat', 5,  2, 3, 5, 7, 10,  1,1,1,1,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Flurry of Blows', 'FLURRY', 'combat', 3,  3, 6, 9, 'NONE', 'NONE',  0,0,0,1,0,0,0,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Garrote', 'GARROTE', 'combat', 5,  2, 4, 6, 8, 10,  1,0,0,1,0,1,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Grapple Mastery', 'GMSATERY', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES (\"Griffin's Voice\", 'GRIFFIN', 'combat', 3,  3, 6, 9, 'NONE', 'NONE',  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Groin Kick', 'GKICK', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Hamstring', 'HAMSTRING', 'combat', 5,  2, 4, 6, 8, 10,  1,0,0,0,0,1,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Haymaker', 'HAYMAKER', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Headbutt', 'HAYMAKER', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Inner Harmony', 'IHARMONY', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,1,0,0,0,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Internal Power', 'IPOWER', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,0,0,0,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Ki Focus', 'IPOWER', 'combat', 3,  3, 6, 9, 'NONE', 'NONE',  0,0,0,1,0,0,0,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Kick Mastery', 'KMSATERY', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Mighty Blow', 'MBLOW', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Multi-Fire', 'DISARM', 'combat', 5,  2, 4, 6, 8, 10,  1,1,1,1,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Mystic Strike', 'MYSTICSTRIKE', 'combat', 5,  2, 3, 4, 5, 6,  0,0,0,1,0,0,0,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Parry Mastery', 'PMASTERY', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Perfect Self', 'PERFECTSELF', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,0,0,0,0,0,0,0, 'CM:Burst of Swiftness:3&CM:Surge of Strength:3') "
      db.execute "INSERT INTO Maneuvers VALUES ('Precision', 'PRECISION', 'combat', 2,  4, 6, 'NONE', 'NONE', 'NONE',  1,1,1,1,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Punch Mastery', 'PUNCHMASTERY', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES (\"Predator's Eye\", 'PREDATOR', 'combat', 3,  4, 6, 8, 'NONE', 'NONE',  0,0,0,0,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Quickstrike', 'QSTRIKE', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Rolling Krynch Stance', 'KRYNCH', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,1,0,0,0,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shadow Mastery', 'SMASTERY', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,1,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Bash', 'SBASH', 'combat', 5,  2, 4, 6, 8, 10,  1,0,0,0,1,1,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Charge', 'SCHARGE', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Side By Side', 'SIDEBYSIDE', 'combat', 5,  2, 4, 6, 8, 10,  1,1,1,1,1,1,1,1,1,1,1, 'CM:Combat Movement:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Silent Strike', 'SILENTSTRIKE', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,1,0,0,0,0, 'CM:Shadow Mastery:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Slippery Mind', 'SLIPPERYMIND', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,1,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Specialization I', 'WSPEC1', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Specialization II', 'WSPEC2', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Specialization III', 'WSPEC3', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Spell Cleaving', 'SCLEAVE', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Spell Parry', 'SPARRY', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Spell Thieve', 'THIEVE', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Spin Attack', 'SATTACK', 'combat', 5,  2, 4, 6, 8, 10,  1,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Staggering Blow', 'SBLOW', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Stance of the Mongoose', 'MONGOOSE', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,1,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Striking Asp Stance', 'ASP', 'combat', 3,  4, 8, 12, 'NONE', 'NONE', 0,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Stun Maneuvers', 'STUNMAN', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Subdue', 'SUBDUE', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Sucker Punch', 'SPUNCH', 'combat', 5,  2, 3, 4, 5, 6,  0,0,0,0,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Subdual Strike', 'SSTRIKE', 'combat', 5,  2, 3, 4, 5, 6,  1,1,1,1,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Sunder Shield', 'SUNDER', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Surge of Strength', 'SUNDER', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,1,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Sweep', 'SWEEP', 'combat', 5,  2, 4, 6, 8, 10,  1,0,0,1,0,1,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Tackle', 'TACKLE', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Tainted Bond', 'TAINTED', 'combat', 1,  12, 'NONE', 'NONE', 'NONE', 'NONE',  0,0,0,0,1,0,0,0,0,1,0, 'CM:Weapon Bonding:5|Skill:Spell Research, Paladin:25') "
      db.execute "INSERT INTO Maneuvers VALUES ('Trip', 'TRIP', 'combat', 5,  2, 4, 6, 8, 10,  1,1,1,1,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Truehand', 'TRUEHAND', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Twin Hammerfists', 'TWINHAMM', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Unarmed Specialist', 'UNARMEDSPEC', 'combat', 1,  6, 'NONE', 'NONE', 'NONE', 'NONE',  1,1,1,0,1,1,1,1,1,1,1, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Vanish', 'VANISH', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,0,0,0,1,0,0,0,0, 'CM:Shadow Mastery:4') "
      db.execute "INSERT INTO Maneuvers VALUES ('Weapon Bonding', 'BOND', 'combat', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,0,0,0,1,0, 'CM:Specialization I:3|CM:Specialization II:3|CM:Specialization III:3') "
      db.execute "INSERT INTO Maneuvers VALUES ('Whirling Dervish', 'DERVISH', 'combat', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,0,0,0,1,0,0,1,0, 'NONE') "

      db.execute "INSERT INTO Maneuvers VALUES ('Small Shield Focus', 'SFOCUS', 'shield', 5,  4, 6, 8, 10, 12,  0,0,0,0,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Medium Shield Focus', 'MFOCUS', 'shield', 5,  4, 6, 8, 10, 12,  0,0,0,0,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Large Shield Focus', 'LFOCUS', 'shield', 5,  4, 6, 8, 10, 12,  0,0,0,0,1,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Tower Shield Focus', 'TFOCUS', 'shield', 5,  4, 6, 8, 10, 12,  0,0,0,0,1,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Bash', 'SBASH', 'shield', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Charge', 'SCHARGE', 'shield', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,0,0,0,1,0, 'SM:Shield Bash:2|CM:Shield Bash:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Push', 'PUSH', 'shield', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,0,0,0,1,0, 'SM:Shield Bash:2|CM:Shield Bash:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Pin', 'PIN', 'shield', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,0,0,0,1,0, 'SM:Shield Bash:2|CM:Shield Bash:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Swiftness', 'SWIFTNESS', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,0,0,1,0,0,1,0, 'SM:Small Shield Focus:3|SM:Medium Shield Focus:3') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shielded Brawler', 'BRAWLER', 'shield', 5,  6, 8, 10, 12, 14,  0,0,0,0,1,0,1,0,0,1,0, 'SM:Small Shield Focus:3|SM:Medium Shield Focus:3|SM:Large Shield Focus:3|SM:Tower Shield Focus:3') "
      db.execute "INSERT INTO Maneuvers VALUES ('Prop Up', 'PROP', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,1,0,0,0,0,1,0, 'SM:Large Shield Focus:3|SM:Tower Shield Focus:3') "
      db.execute "INSERT INTO Maneuvers VALUES ('Adamantine Bulwark', 'BULWARK', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,0,0,0,0,0,1,0, 'SM:Prop Up:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Riposte', 'RIPOSTE', 'shield', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,0,0,0,1,0,0,1,0, 'SM:Shield Bash:2|CM:Shield Bash:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Forward', 'FORWARD', 'shield', 3,  4, 8, 12, 'NONE', 'NONE',  0,0,0,0,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Spike Focus', 'SPIKEFOCUS', 'shield', 2,  8, 12, 'NONE', 'NONE', 'NONE',  0,0,0,0,1,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Spike Mastery', 'SPIKEMASTERY', 'shield', 2,  8, 12, 'NONE', 'NONE', 'NONE',  0,0,0,0,1,0,1,0,0,1,0, 'SM:Shield Spike Focus:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Deflection Training', 'DTRAINING', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,0,0,1,0,0,1,0, 'SM:Small Shield Focus:3|SM:Medium Shield Focus:3|SM:Large Shield Focus:3|SM:Tower Shield Focus:3') "
      db.execute "INSERT INTO Maneuvers VALUES ('Deflection Mastery', 'DMASTERY', 'shield', 5,  8, 10, 12, 14, 16,  0,0,0,0,0,0,1,0,0,1,0, 'SM:Deflection Training:3') "
      db.execute "INSERT INTO Maneuvers VALUES ('Block the Elements', 'EBLOCK', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,1,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Deflect the Elements', 'DEFLECT', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,0,0,1,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Steady Shield', 'STEADY', 'shield', 2,  4, 6, 'NONE', 'NONE', 'NONE',  0,0,0,0,0,0,1,0,0,1,0, 'CM:Stun Maneuvers:2|GS:Stun Maneuvers:20') "
      db.execute "INSERT INTO Maneuvers VALUES ('Disarming Presence', 'DPRESENCE', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,0,0,1,0,0,1,0, 'CM:Disarm Weapon:2|GS:Disarm Weapon:20') "
      db.execute "INSERT INTO Maneuvers VALUES ('Guard Mastery', 'GUARDMASTERY', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Tortoise Stance', 'TORTOISE', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,0,0,0,0,0,1,0, 'SM:Block Mastery:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Spell Block', 'SPELLBLOCK', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,1,0,1,0,0,1,0, 'SM:Small Shield Focus:3|SM:Medium Shield Focus:3|SM:Large Shield Focus:3|SM:Tower Shield Focus:3') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Mind', 'MIND', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,1,0,1,0,0,1,0, 'SM:Spell Block:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Protective Wall', 'PWALL', 'shield', 2,  4, 5, 'NONE', 'NONE', 'NONE',  0,0,0,0,1,0,0,0,0,1,0, 'SM:Tower Shield Focus:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Strike', 'STRIKE', 'shield', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,1,0,0,1,0, 'SM:Shield Bash:2|CM:Shield Bash:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Strike Mastery', 'STRIKEMASTERY', 'shield', 1,  30, 'NONE', 'NONE', 'NONE', 'NONE',  0,0,0,0,1,0,1,0,0,1,0, 'SM:Shield Strike:2&Skill:Multi Opponent Combat:30') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Trample', 'TRAMPLE', 'shield', 5,  2, 4, 6, 8, 10,  0,0,0,0,0,0,0,0,0,1,0, 'SM:Shield Charge:2') "
      db.execute "INSERT INTO Maneuvers VALUES ('Shield Trample Mastery', 'TMASTERY', 'shield', 3,  8, 10, 12, 'NONE', 'NONE',  0,0,0,0,0,0,0,0,0,1,0, 'SM:Shield Trample:3&Skill:Multi Opponent Combat:30') "
      db.execute "INSERT INTO Maneuvers VALUES ('Steely Resolve', 'RESOLVE', 'shield', 3,  6, 12, 18, 'NONE', 'NONE',  0,0,0,0,1,0,0,0,0,1,0, 'SM:Tower Shield Focus:3') "
      db.execute "INSERT INTO Maneuvers VALUES ('Phalanx', 'PHALANX', 'shield', 5,  2, 4, 6, 8, 10,  0,0,0,0,1,0,1,0,0,1,0, 'NONE') "

      db.execute "INSERT INTO Maneuvers VALUES ('Crush Protection', 'CRUSH', 'armor', 5,  20, 30, 40, 50, 60,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Puncture Protection', 'PUNCTURE', 'armor', 5,  20, 30, 40, 50, 60,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Slash Protection', 'SLASH', 'armor', 5,  20, 30, 40, 50, 60,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Armor Blessing', 'BLESSING', 'armor', 5,  20, 30, 40, 50, 60,  0,0,0,0,1,0,0,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Armored Casting', 'CASTING', 'armor', 5,  20, 30, 40, 50, 60,  0,0,0,0,1,0,0,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Armored Evasion', 'EVASION', 'armor', 5,  20, 30, 40, 50, 60,  0,0,0,0,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Armored Fluidity', 'FLUIDITY', 'armor', 5,  20, 30, 40, 50, 60,  0,0,0,0,1,0,0,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Armor Reinforcement', 'REINFORCE', 'armor', 5,  20, 30, 40, 50, 60,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Armored Stealth', 'STEALTH', 'armor', 5,  20, 30, 40, 50, 60,  0,0,0,0,0,0,1,0,0,0,0, 'NONE') "
      db.execute "INSERT INTO Maneuvers VALUES ('Armor Support', 'SUPPORT', 'armor', 5,  20, 30, 40, 50, 60,  0,0,0,0,0,0,0,0,0,1,0, 'NONE') "
    end
  end

  # returns the number of rows in the races table.
  #   Used to see if we need to populate the table, and input for unit testing
  def getRowCount
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true
    db.get_first_value "SELECT Count() from Maneuvers"
  end

  # truncates the races table
  #   Used primarily for unit testing
  def resetDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.execute "DELETE FROM Maneuvers"
  end

  # Returns a hash based on the race passed in
  def getManeuverObjectFromDatabase(name)
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    results = db.query "SELECT * from Maneuvers where name=?", name
    result = results.next

    cost = {ranks: result['ranks'], rank1: result['cost_rank1'], rank2: result['cost_rank2'], rank3: result['cost_rank3'], rank4: result['cost_rank4'], rank5: result['cost_rank5']}

    result.delete('ranks')
    result.delete('cost_rank1')
    result.delete('cost_rank2')
    result.delete('cost_rank3')
    result.delete('cost_rank4')
    result.delete('cost_rank5')

    available = {bard: result['available_bard'], cleric: result['available_cleric'], empath: result['available_empath'], monk: result['available_monk'],
                 paladin: result['available_paladin'], ranger: result['available_ranger'], rogue: result['available_rogue'], savant: result['available_savant'],
                 sorcerer: result['available_sorcerer'], warrior: result['available_warrior'], wizard: result['available_wizard']}

   # available_bard, available_cleric, available_empath, available_monk, available_paladin, available_ranger, available_rogue, available_savant,
    # available_sorcerer, available_warrior, available_wizard
    result.delete('available_bard')
    result.delete('available_cleric')
    result.delete('available_empath')
    result.delete('available_monk')
    result.delete('available_paladin')
    result.delete('available_ranger')
    result.delete('available_rogue')
    result.delete('available_savant')
    result.delete('available_sorcerer')
    result.delete('available_warrior')
    result.delete('available_wizard')

    result.merge!(cost: cost)
    result.merge!(available: available)
  end

end