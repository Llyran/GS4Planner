require "sqlite3"

class Weapons
  DatabaseName = './data/test.db'

  #constructor
  def initialize
    createDatabaseTable
  end

  # create SQLite3 table for races
  def createDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    # Creates the Weapons table which contains all the weapons and their attributes
    db.execute "CREATE TABLE IF NOT EXISTS Weapons (name, weapon_type, base_weight, base_speed, minimum_speed, damage_type, str_du,  df_vs_cloth, df_vs_leather, df_vs_scale, df_vs_chain, df_vs_plate,  avd_1, avd_2,  avd_5, avd_6, avd_7, avd_8,  avd_9, avd_10, avd_11, avd_12,  avd_13, avd_14, avd_15, avd_16,  avd_17, avd_18, avd_19, avd_20  ) "

    results = db.get_first_value "SELECT Count() from Weapons";
    if results == 0
      # Brawling
      db.execute "INSERT INTO Weapons VALUES('Blackjack', 'Brawling', 3, 1, 3, 'Crush', '50/80',  .250, .140, .090, .110, .075,  40, 40,  35, 34, 33, 32,  25, 23, 21, 19,  15, 11, 7, 3,  0, -6, -12, -18) "
      db.execute "INSERT INTO Weapons VALUES('Cestus', 'Brawling', 2, 1, 3, 'Crush', '50/80',  .250, .175, .150, .075, .035,  40, 40,  30, 29, 28, 27,  20, 18, 16, 14,  10, 6, 2, -2,  -25, -31, -37, -43) "
      db.execute "INSERT INTO Weapons VALUES('Closed Fist', 'Brawling', 0, 1, 3, 'Crush', '--/--',  .100, .075, .040, .036, .032,  25, 25,  20, 19, 18, 17,  10, 8, 6, 4,  5, 1, -3, -7,  -5, -11, -17, -23) "
      db.execute "INSERT INTO Weapons VALUES('Fist-scythe', 'Brawling', 4, 2, 4, 'Slash/Puncture/Crush', '70/185',  .350, .225, .200, .175, .125,  45, 45,  40, 39, 38, 37,  30, 28, 26, 24,  37, 33, 29, 25,  20, 14, 8, 2) "
      db.execute "INSERT INTO Weapons VALUES('Hook-knife', 'Brawling', 1, 1, 3, 'Slash/Puncture', '30/100',  .250, .175, .125, .070, .035,  40, 40,  30, 29, 28, 27,  18, 16, 14, 12,  10, 6, 2, -2,  -15, -21, -27, -33) "
      db.execute "INSERT INTO Weapons VALUES('Jackblade', 'Brawling', 3, 2, 4, 'Slash/Crush', '60/90',  .250, .175, .150, .150, .110,  45, 45,  35, 34, 33, 32,  25, 23, 21, 19,  20, 16, 12, 8,  10, 4, -2, -8) "
      db.execute "INSERT INTO Weapons VALUES('Knuckle-blade', 'Brawling', 2, 1, 3, 'Slash/Crush', '18/195',  .250, .150, .100, .075, .075,  45, 45,  40, 39, 38, 37,  25, 23, 21, 19,  25, 21, 17, 13,  0, -6, -12, -18) "
      db.execute "INSERT INTO Weapons VALUES('Knuckle-duster', 'Brawling', 1, 1, 3, 'Crush', '18/199',  .250, .175, .125, .100, .040,  35, 35,  32, 31, 30, 29,  25, 23, 21, 19,  18, 14, 10, 6,  0, -6, -12, -18) "
      db.execute "INSERT INTO Weapons VALUES('Paingrip', 'Brawling', 2, 1, 3, 'Slash/Puncture/Crush', '50/80',  .225, .200, .125, .075, .030,  40, 40,  20, 19, 18, 17,  15, 13, 11, 9,  15, 11, 7, 3,  -25, -31, -37, -43) "
      db.execute "INSERT INTO Weapons VALUES('Razorpaw', 'Brawling', 2, 1, 3, 'Slash', '40/80',  .275, .200, .125, .050, .030,  35, 35,  20, 19, 18, 17,  10, 8, 6, 4,  0, -4, -8, -12,  -25, -31, -37, -43) "
      db.execute "INSERT INTO Weapons VALUES('Sai', 'Brawling', 0, 2, 4, 'Puncture', '25/175',  .250, .200, .110, .150, .040,  30, 30,  31, 30, 29, 28,  25, 23, 21, 19,  33, 29, 25, 21,  6, 0, -6, -12) "
      db.execute "INSERT INTO Weapons VALUES('Tiger-claw', 'Brawling', 1, 1, 3, 'Slash/Crush', '18/165',  .275, .200, .150, .100, .035,  40, 40,  25, 24, 23, 22,  15, 13, 11, 9,  5, 1, -3, -7,  -25, -31, -37, -43) "
      db.execute "INSERT INTO Weapons VALUES('Troll-claw', 'Brawling', 3, 2, 4, 'Slash/Crush', '60/185',  .325, .175, .140, .120, .090,  45, 45,  35, 34, 33, 32,  25, 23, 21, 19,  25, 21, 17, 13,  15, 9, 3, -3) "
      db.execute "INSERT INTO Weapons VALUES('Yierka-spur', 'Brawling', 2, 1, 3, 'Slash/Puncture/Crush', '18/185',  .250, .150, .125, .125, .075,  40, 40,  35, 34, 33, 32,  25, 23, 21, 19,  30, 26, 22, 18,  0, -6, -12, -18) "

      # One-handed Blunt Weapons	 
      db.execute "INSERT INTO Weapons VALUES('Ball and Chain', 'Blunt Weapons', 9, 6, 5, 'Crush', '75/175',  .400, .300, .225, .260, .180,  15, 15,  20, 19, 18, 17,  27, 25, 23, 21,  35, 31, 27, 34,  30, 24, 18, 12) "
      db.execute "INSERT INTO Weapons VALUES('Crowbill', 'Blunt Weapons', 5, 3, 4, 'Puncture/Crush', '65/250',  .350, .250, .200, .150, .125,  40, 40,  36, 35, 34, 33,  30, 28, 26, 24,  30, 26, 22, 18,  20, 14, 8, 2) "
      db.execute "INSERT INTO Weapons VALUES('Cudgel', 'Blunt Weapons', 4, 4, 5, 'Crush', '8/130',  .350, .275, .200, .225, .150,  20, 20,  20, 19, 18, 17,  25, 23, 21, 19,  25, 21, 17, 13,  30, 24, 18, 12) "
      db.execute "INSERT INTO Weapons VALUES('Leather Whip', 'Blunt Weapons', 5, 2, 4, 'Crush', '10/75',  .275, .150, .090, .100, .035,  35, 35,  25, 24, 23, 22,  20, 18, 16, 14,  25, 21, 17, 13,  15, 9, 3, -3) "
      db.execute "INSERT INTO Weapons VALUES('Mace', 'Blunt Weapons', 8, 4, 5, 'Crush', '65/250',  .400, .300, .225, .250, .175,  31, 31,  32, 31, 30, 29,  35, 33, 31, 29,  42, 38, 34, 30,  36, 30, 24, 18) "
      db.execute "INSERT INTO Weapons VALUES('Morning Star', 'Blunt Weapons', 8, 5, 5, 'Puncture/Crush', '60/155',  .410, .290, .250, .275, .200,  33, 33,  35, 34, 33, 32,  34, 32, 30, 28,  42, 38, 34, 30,  37, 31, 25, 19) "
      db.execute "INSERT INTO Weapons VALUES('War Hammer', 'Blunt Weapons', 7, 4, 5, 'Puncture/Crush', '65/250',  .425, .325, .275, .300, .225,  25, 25,  30, 29, 28, 27,  32, 30, 28, 26,  41, 37, 33, 29,  37, 31, 25, 19) "

      # One-handed Edged Weapons	 
      db.execute "INSERT INTO Weapons VALUES('Arrows/Bolts', 'Edged Weapons', 0, 5, 5, 'Slash/Puncture', '20/40',  .200, .100, .080, .100, .040,  20, 20,  18, 17, 16, 15,  10, 8, 6, 4,  5, 1, -3, -7,  -5, -11, -17, -23) "
      db.execute "INSERT INTO Weapons VALUES('Backsword', 'Edged Weapons', 5, 5, 5, 'Slash/Puncture/Crush', '75/160',  .440, .310, .225, .240, .150,  38, 38,  38, 37, 36, 35,  34, 32, 30, 28,  38, 34, 30, 26,  34, 28, 22, 16) "
      db.execute "INSERT INTO Weapons VALUES('Bastard Sword, One-Handed', 'Edged Weapons', 9, 6, 5, 'Slash/Crush', '75/200',  .450, .325, .275, .250, .180,  30, 30,  31, 30, 29, 28,  31, 29, 27, 25,  32, 28, 24, 20,  31, 25, 19, 13) "
      db.execute "INSERT INTO Weapons VALUES('Broadsword', 'Edged Weapons', 5, 5, 5, 'Slash/Puncture/Crush', '75/160',  .450, .300, .250, .225, .200,  36, 36,  36, 35, 34, 33,  36, 34, 32, 30,  37, 33, 29, 25,  36, 30, 24, 18) "
      db.execute "INSERT INTO Weapons VALUES('Dagger', 'Edged Weapons', 1, 1, 3, 'Slash/Puncture', '18/195',  .250, .200, .100, .125, .075,  25, 25,  23, 22, 21, 20,  15, 13, 11, 9,  10, 6, 2, -2,  0, -6, -12, -18) "
      db.execute "INSERT INTO Weapons VALUES('Estoc', 'Edged Weapons', 4, 4, 5, 'Slash/Puncture', '65/160',  .425, .300, .200, .200, .150,  36, 36,  38, 37, 36, 35,  35, 33, 31, 29,  40, 36, 32, 28,  30, 24, 18, 12) "
      db.execute "INSERT INTO Weapons VALUES('Falchion', 'Edged Weapons', 5, 5, 5, 'Slash/Crush', '75/160',  .450, .325, .250, .250, .175,  35, 35,  37, 36, 35, 34,  38, 36, 34, 32,  39, 35, 31, 27,  39, 33, 27, 21) "
      db.execute "INSERT INTO Weapons VALUES('Handaxe', 'Edged Weapons', 6, 5, 5, 'Slash/Crush', '70/160',  .420, .300, .270, .240, .210,  30, 30,  32, 31, 30, 29,  38, 36, 34, 32,  41, 37, 33, 29,  41, 35, 29, 23) "
      db.execute "INSERT INTO Weapons VALUES('Katana, One-Handed', 'Edged Weapons/Two-Handed Weapons', 6, 5, 5, 'Slash', '75/225',  .450, .325, .250, .250, .175,  38, 38,  36, 35, 34, 33,  36, 34, 32, 30,  37, 33, 29, 25,  35, 29, 23, 17) "
      db.execute "INSERT INTO Weapons VALUES('Katar', 'Edged Weapons/Brawling', 4, 3, 4, 'Slash/Puncture', '70/175',  .325, .250, .225, .200, .175,  30, 30,  32, 31, 30, 29,  40, 38, 36, 34,  45, 41, 37, 33,  40, 34, 28, 22) "
      db.execute "INSERT INTO Weapons VALUES('Longsword', 'Edged Weapons', 5, 4, 5, 'Slash/Puncture/Crush', '65/160',  .425, .275, .225, .200, .175,  41, 41,  42, 41, 40, 39,  43, 41, 39, 37,  37, 33, 29, 25,  35, 29, 23, 17) "
      db.execute "INSERT INTO Weapons VALUES('Main Gauche', 'Edged Weapons', 2, 2, 4, 'Slash/Puncture', '18/190',  .275, .210, .110, .125, .075,  27, 27,  25, 24, 23, 22,  20, 18, 16, 14,  20, 16, 12, 8,  20, 14, 8, 2) "
      db.execute "INSERT INTO Weapons VALUES('Rapier', 'Edged Weapons', 3, 2, 4, 'Slash/Puncture', '30/100',  .325, .225, .110, .125, .075,  45, 45,  40, 39, 38, 37,  30, 28, 26, 24,  35, 31, 27, 23,  15, 9, 3, -3) "
      db.execute "INSERT INTO Weapons VALUES('Scimitar', 'Edged Weapons', 5, 4, 5, 'Slash/Puncture/Crush', '60/150',  .375, .260, .210, .200, .165,  30, 30,  31, 30, 29, 28,  30, 28, 26, 24,  30, 26, 22, 18,  30, 24, 18, 12) "
      db.execute "INSERT INTO Weapons VALUES('Short Sword', 'Edged Weapons', 4, 3, 4, 'Slash/Puncture/Crush', '70/185',  .350, .240, .200, .150, .125,  40, 40,  36, 35, 34, 33,  30, 28, 26, 24,  25, 21, 17, 13,  25, 19, 13, 7) "
      db.execute "INSERT INTO Weapons VALUES('Whip-blade', 'Edged Weapons', 0, 2, 4, 'Slash', '30/100',  .333, .250, .225, .200, .175,  45, 45,  40, 39, 38, 37,  30, 28, 26, 24,  35, 31, 27, 23,  15, 9, 3, -3) "

      # Polearm Weapons	 
      db.execute "INSERT INTO Weapons VALUES('Halberd', 'Polearm Weapons', 9, 6, 5, 'Slash/Crush/Puncture', '25/150',  .550, .400, .400, .300, .200,  30, 30,  30, 29, 28, 27,  31, 29, 27, 25,  32, 28, 24, 20,  32, 26, 20, 14) "
      db.execute "INSERT INTO Weapons VALUES('Hammer of Kai', 'Polearm Weapons', 9, 7, 5, 'Puncture/Crush', '50/190',  .550, .425, .450, .350, .250,  20, 20,  25, 24, 23, 22,  35, 33, 31, 29,  40, 36, 32, 28,  40, 34, 28, 22) "
      db.execute "INSERT INTO Weapons VALUES('Jeddart-axe', 'Polearm Weapons', 9, 6, 5, 'Slash/Crush', '25/150',  .550, .425, .425, .325, .250,  30, 30,  32, 31, 30, 29,  30, 28, 26, 24,  40, 36, 32, 28,  30, 24, 18, 12) "
      db.execute "INSERT INTO Weapons VALUES('Lance', 'Polearm Weapons', 15, 9, 5, 'Puncture/Crush', '17/105',  .725, .525, .550, .475, .350,  35, 35,  38, 37, 36, 35,  39, 37, 35, 33,  53, 49, 45, 41,  50, 44, 38, 32) "
      db.execute "INSERT INTO Weapons VALUES('Naginata', 'Polearm Weapons', 0, 6, 5, 'Slash/Crush/Puncture', '25/150',  .550, .400, .400, .300, .200,  50, 50,  50, 49, 48, 47,  51, 49, 47, 45,  52, 48, 44, 40,  52, 46, 40, 34) "
      db.execute "INSERT INTO Weapons VALUES('Pilum', 'Polearm Weapons', 5, 3, 4, 'Slash/Puncture', '50/150',  .350, .250, .225, .175, .060,  30, 30,  27, 26, 25, 24,  22, 20, 18, 16,  23, 19, 15, 11,  15, 9, 3, -3) "
      db.execute "INSERT INTO Weapons VALUES('Spear, One-Handed', 'Polearm Weapons', 0, 5, 5, 'Slash/Puncture', '15/130',  .425, .325, .250, .250, .260,  27, 27,  29, 28, 27, 26,  27, 25, 23, 21,  30, 26, 22, 18,  25, 19, 13, 7) "
      db.execute "INSERT INTO Weapons VALUES('Spear, Two-Handed', 'Polearm Weapons', 0, 5, 5, 'Slash/Puncture', '15/130',  .550, .385, .340, .325, .230,  33, 33,  32, 31, 30, 29,  34, 32, 30, 28,  36, 32, 28, 24,  33, 27, 21, 15) "
      db.execute "INSERT INTO Weapons VALUES('Trident, One-Handed', 'Polearm Weapons', 12, 5, 5, 'Slash/Puncture', '70/190',  .425, .350, .260, .230, .150,  31, 31,  31, 30, 29, 28,  34, 32, 30, 28,  42, 38, 34, 30,  29, 23, 17, 11) "
      db.execute "INSERT INTO Weapons VALUES('Trident, Two-Handed', 'Polearm Weapons', 12, 6, 5, 'Slash/Puncture', '70/190',  .600, .425, .375, .300, .185,  29, 29,  30, 29, 28, 27,  30, 28, 26, 24,  37, 33, 29, 25,  25, 19, 13, 7) "

      # Ranged Weapons	 
      db.execute "INSERT INTO Weapons VALUES('Composite Bow', 'Ranged Weapons', 3, 6, 3, 'Puncture', '50/225',  .350, .300, .325, .275, .150,  25, 25,  35, 34, 33, 32,  30, 28, 26, 24,  42, 38, 34, 30,  36, 30, 24, 18) "
      db.execute "INSERT INTO Weapons VALUES('Long Bow', 'Ranged Weapons', 3, 7, 3, 'Puncture', '60/315',  .400, .325, .350, .300, .175,  25, 25,  33, 32, 31, 30,  29, 27, 25, 23,  42, 38, 34, 30,  38, 32, 26, 20) "
      db.execute "INSERT INTO Weapons VALUES('Short Bow', 'Ranged Weapons', 3, 5, 3, 'Puncture', '35/180',  .325, .225, .275, .250, .100,  20, 20,  27, 26, 25, 24,  20, 18, 16, 14,  31, 27, 23, 19,  27, 21, 15, 9) "
      db.execute "INSERT INTO Weapons VALUES('Heavy Crossbow', 'Ranged Weapons', 12, 2, 2, 'Puncture', '60/315',  .425, .325, .375, .285, .175,  30, 30,  36, 35, 34, 33,  31, 29, 27, 25,  46, 42, 38, 34,  40, 34, 28, 22) "
      db.execute "INSERT INTO Weapons VALUES('Light Crossbow', 'Ranged Weapons', 8, 2, 2, 'Puncture', '60/315',  .350, .300, .325, .275, .150,  25, 25,  31, 30, 29, 28,  25, 23, 21, 19,  39, 35, 31, 27,  32, 26, 20, 14) "

      # Thrown Weapons	
      db.execute "INSERT INTO Weapons VALUES('Bola', 'Thrown Weapons', 0, 5, 3, 'Crush', '12/75',  .205, .158, .107, .118, .067,  25, 25,  20, 19, 18, 17,  30, 28, 26, 24,  25, 21, 17, 13,  35, 29, 23, 17) "
      db.execute "INSERT INTO Weapons VALUES('Dart', 'Thrown Weapons', 0, 2, 3, 'Puncture', '10/85',  .125, .100, .075, .055, .050,  35, 35,  30, 29, 28, 27,  25, 23, 21, 19,  20, 16, 12, 8,  10, 4, -2, -8) "
      db.execute "INSERT INTO Weapons VALUES('Discuss', 'Thrown Weapons', 0, 5, 3, 'Crush', '60/195',  .255, .230, .155, .110, .057,  40, 40,  35, 34, 33, 32,  30, 28, 26, 24,  25, 21, 17, 13,  30, 24, 18, 12) "
      db.execute "INSERT INTO Weapons VALUES('Javelin', 'Thrown Weapons', 0, 4, 3, 'Puncture', '17/105',  .402, .304, .254, .254, .102,  27, 27,  28, 27, 25, 25,  26, 24, 22, 20,  29, 25, 21, 17,  20, 14, 8, 2) "
      db.execute "INSERT INTO Weapons VALUES('Net', 'Thrown Weapons', 0, 7, 3, 'Unbalance', '45/160',  .050, .050, .030, .030, .010,  25, 25,  25, 24, 23, 22,  30, 28, 26, 24,  40, 36, 32, 28,  50, 44, 38, 32) "
      db.execute "INSERT INTO Weapons VALUES('Quoit', 'Thrown Weapons', 0, 5, 3, 'Slash', '60/155',  .255, .230, .155, .110, .057,  40, 40,  35, 34, 33, 32,  30, 28, 26, 24,  25, 21, 17, 13,  30, 24, 18, 12) "

      # Two-Handed Weapons	
      db.execute "INSERT INTO Weapons VALUES('Battle Axe', 'Two-Handed Weapons', 9, 8, 5, 'Slash/Crush', '70/155',  .650, .475, .500, .375, .275,  35, 35,  39, 38, 37, 36,  43, 41, 39, 37,  50, 46, 42, 38,  50, 44, 38, 32) "
      db.execute "INSERT INTO Weapons VALUES('Bastard Sword, Two-Handed', 'Two-Handed Weapons', 9, 6, 5, 'Slash/Crush', '75/200',  .550, .400, .375, .300, .225,  42, 42,  45, 44, 43, 42,  41, 39, 37, 35,  44, 40, 36, 32,  43, 37, 31, 25) "
      db.execute "INSERT INTO Weapons VALUES('Claidhmore, new-style', 'Two-Handed Weapons', 11, 8, 5, 'Slash/Crush', '75/200',  .625, .475, .500, .350, .225,  31, 31,  35, 34, 33, 32,  34, 32, 30, 28,  38, 34, 30, 26,  37, 31, 25, 19) "
      db.execute "INSERT INTO Weapons VALUES('Claidhmore, old-style', 'Two-Handed Weapons', 11, 8, 5, 'Slash/Crush', '75/200',  .625, .500, .500, .350, .275,  41, 41,  45, 44, 43, 42,  44, 42, 40, 38,  48, 44, 40, 36,  47, 41, 35, 29) "
      db.execute "INSERT INTO Weapons VALUES('Flail', 'Two-Handed Weapons', 0, 7, 5, 'Puncture/Crush', '60/150',  .575, .425, .400, .350, .250,  40, 40,  45, 44, 43, 42,  46, 44, 42, 40,  51, 47, 43, 39,  52, 46, 40, 34) "
      db.execute "INSERT INTO Weapons VALUES('Flamberge', 'Two-Handed Weapons', 10, 7, 5, 'Slash/Crush', '70/190',  .600, .450, .475, .325, .225,  39, 39,  43, 42, 41, 40,  48, 46, 44, 42,  50, 46, 42, 38,  44, 38, 32, 26) "
      db.execute "INSERT INTO Weapons VALUES('Katana, Two-Handed', 'Two-Handed Weapons', 6, 6, 5, 'Slash', '75/225',  .575, .425, .400, .325, .210,  39, 39,  41, 40, 39, 38,  40, 38, 36, 34,  41, 37, 33, 29,  39, 33, 27, 21) "
      db.execute "INSERT INTO Weapons VALUES('Maul', 'Two-Handed Weapons', 8, 7, 5, 'Crush', '60/145',  .550, .425, .425, .375, .300,  31, 31,  36, 35, 34, 33,  44, 42, 40, 38,  52, 48, 44, 40,  54, 48, 42, 36) "
      db.execute "INSERT INTO Weapons VALUES('Military Pick', 'Two-Handed Weapons', 8, 7, 5, 'Puncture/Crush', '60/150',  .500, .375, .425, .375, .260,  25, 25,  30, 29, 28, 27,  40, 38, 36, 34,  40, 36, 32, 28,  47, 41, 35, 29) "
      db.execute "INSERT INTO Weapons VALUES('Quarterstaff', 'Two-Handed Weapons', 5, 5, 5, 'Crush', '20/140',  .450, .350, .325, .175, .100,  25, 25,  26, 25, 24, 23,  25, 23, 21, 19,  26, 22, 18, 14,  24, 18, 12, 6) "
      db.execute "INSERT INTO Weapons VALUES('Runestaff', 'Two-Handed Weapons', 5, 5, 5, 'Crush', '20/270',  .250, .200, .150, .150, .075,  10, 10,  15, 14, 13, 12,  10, 8, 6, 4,  15, 11, 7, 3,  10, 4, -2, -8) "
      db.execute "INSERT INTO Weapons VALUES('Two-Handed Sword', 'Two-Handed Weapons', 0, 8, 5, 'Slash/Crush', '75/200',  .625, .500, .500, .350, .275,  41, 41,  45, 44, 43, 42,  44, 42, 40, 38,  48, 44, 40, 36,  47, 41, 35, 29) "
      db.execute "INSERT INTO Weapons VALUES('War Mattock', 'Two-Handed Weapons', 8, 7, 5, 'Crush', '60/145',  .550, .450, .425, .375, .275,  32, 32,  37, 36, 35, 34,  44, 42, 40, 38,  48, 44, 40, 36,  53, 47, 41, 35) "

      # Unarmed Combat Gear
      db.execute "INSERT INTO Weapons VALUES('UAC Boots', 'UAC Weapons', 2, 0, 0, 'Crush', '--/--',  0, 0, 0, 0, 0,  0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0) "
      db.execute "INSERT INTO Weapons VALUES('UAC Gloves', 'UAC Weapons', 2, 0, 0, 'Crush', '--/--',  0, 0, 0, 0, 0,  0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0) "

      # UAC Attacks
      db.execute "INSERT INTO Weapons VALUES('Jab', 'UAC Attack', 0, 2, 2, 'Jab', '--/--',  .100, .075, .060, .050, .035,  0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0) "
      db.execute "INSERT INTO Weapons VALUES('Punch', 'UAC Attack', 0, 3, 3, 'Punch', '--/--',  .275, .250, .200, .170, .140,  0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0) "
      db.execute "INSERT INTO Weapons VALUES('Grapple', 'UAC Attack', 0, 3, 3, 'Grapple', '--/--',  .250, .200, .160, .120, .100,  0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0) "
      db.execute "INSERT INTO Weapons VALUES('Kick', 'UAC Attack', 0, 4, 4, 'Kick', '--/--',  .400, .350, .300, .250, .200,  0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0) "

      # Creature Weapons
      db.execute "INSERT INTO Weapons VALUES('Bite', 'Creature Weapons', 0, 5, 5, 'Slash/Crush/Puncture', '--/--',  .400, .375, .375, .325, .300,  39, 39,  35, 34, 33, 32,  30, 28, 26, 24,  32, 28, 24, 20,  25, 19, 13, 7) "
      db.execute "INSERT INTO Weapons VALUES('Charge', 'Creature Weapons', 0, 5, 5, 'Crush', '--/--',  .175, .175, .150, .175, .150,  37, 37,  32, 31, 30, 29,  31, 29, 27, 25,  37, 33, 29, 25,  31, 25, 19, 13) "
      db.execute "INSERT INTO Weapons VALUES('Claw', 'Creature Weapons', 0, 5, 5, 'Slash/Crush/Puncture', '--/--',  .225, .200, .200, .175, .175,  41, 41,  38, 37, 36, 35,  29, 27, 25, 23,  31, 27, 23, 19,  25, 19, 13, 7) "
      db.execute "INSERT INTO Weapons VALUES('Ensnare', 'Creature Weapons', 0, 5, 5, 'Grapple', '--/--',  .275, .225, .200, .175, .150,  25, 25,  31, 30, 29, 28,  40, 38, 36, 34,  38, 34, 30, 26,  50, 44, 38, 32) "
      db.execute "INSERT INTO Weapons VALUES('Nip', 'Creature Weapons', 0, 5, 5, 'Puncture', '--/--',  .125, .105, .090, .090, .100,  35, 35,  40, 39, 38, 37,  25, 23, 21, 29,  28, 24, 20, 16,  20, 14, 8, 2) "
      db.execute "INSERT INTO Weapons VALUES('Pound', 'Creature Weapons', 0, 5, 5, 'Crush', '--/--',  .425, .350, .325, .425, .275,  38, 38,  45, 44, 43, 42,  46, 44, 42, 40,  50, 46, 42, 38,  50, 44, 38, 32) "
      db.execute "INSERT INTO Weapons VALUES('Stomp', 'Creature Weapons', 0, 5, 5, 'Crush', '--/--',  .350, .325, .250, .225, .225,  39, 39,  45, 44, 43, 42,  35, 33, 31, 29,  45, 41, 37, 33,  33, 27, 21, 15) "

    end
  end

  # returns the number of rows in the races table.
  #   Used to see if we need to populate the table, and input for unit testing
  def getRowCount
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true
    db.get_first_value "SELECT Count() from Weapons";
  end

  # truncates the races table
  #   Used primarily for unit testing
  def resetDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.execute "DELETE FROM Weapons"
  end

  # Returns a hash based on the race passed in
  def getWeaponObjectFromDatabase(name)
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    results = db.query "SELECT * from Weapons where name=?", name
    result = results.next

    dfAgainst = { cloth: result['df_vs_cloth'], leather: result['df_vs_leather'], scale: result['df_vs_scale'], chain: result['df_vs_chain'], plate: result['df_vs_plate'] }

    result.delete('df_vs_cloth')
    result.delete('df_vs_leather')
    result.delete('df_vs_scale')
    result.delete('df_vs_chain')
    result.delete('df_vs_plate')

    aVd = { '1': result['avd_1'], '2': result['avd_2'], '5': result['avd_5'], '6': result['avd_6'], '7': result['avd_7'], '8': result['avd_8'], '9': result['avd_9'],
                        '10': result['avd_10'], '11': result['avd_11'], '12': result['avd_12'], '13': result['avd_13'], '14': result['avd_14'], '15': result['avd_15'],
                        '16': result['avd_16'], '17': result['avd_17'], '18': result['avd_18'], '19': result['avd_19'], '20': result['avd_20'] }

    result.delete('avd_1')
    result.delete('avd_2')
    result.delete('avd_5')
    result.delete('avd_6')
    result.delete('avd_7')
    result.delete('avd_8')
    result.delete('avd_9')
    result.delete('avd_10')
    result.delete('avd_11')
    result.delete('avd_12')
    result.delete('avd_13')
    result.delete('avd_14')
    result.delete('avd_15')
    result.delete('avd_16')
    result.delete('avd_17')
    result.delete('avd_18')
    result.delete('avd_19')
    result.delete('avd_20')

    result.merge!(dfAgainst)
    result.merge!(aVd)
  end

end 