require "sqlite3"

class Effects
  DatabaseName = './data/test.db'

  def initialize
    createDatabaseTable
  end

  def createDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    # Creates the effects table. An effect is any sort of temporary effect that modifies the character in some way.
    # Effects are setup in the Loadout panel and used as part of the calulcation of the Progression panel
    # FIELDS
    # name 				- name of the effect
    # type 				- the type category of the effect. This could be a spell's spell circle, or an "Maneuver" type effect
    # details 			- a description of what the effect does
    # effect_tags 		- A | (pipe) seperated list of what attributes the effect modifies. A $ at the end of the effect means the effect only modifies the attribute with scaling, a * means
    #					  it the effect modifies the attribute by default and by scaling, nothing on the end means it modifies an attribute but doesn't scale
    # scaling_tags 		- NONE means the effect doesn't scale off anything. Otherwise it is a | (pipe) seperated list of things the effect will scale off of in the format of 
    #	 				  <scales by>:<value range>.  A single value in <value range> means the scaling effect is from 0 to that value.
    # function 			- The name of the function that will perform all the scaling calculations related to this effect
    # override_options 	- A | (pipe) seperated list of parameters that need to be taken into consideration when calculating or display the effect
    db.execute "CREATE TABLE IF NOT EXISTS Effects (name, type, details, effect_tags, scaling_tags, function, override_options ) "

    results = db.get_first_value "SELECT Count() from Effects";
    if results == 0
      # Minor Spiritual (100s)
      db.execute "INSERT INTO Effects VALUES('Spirit Warding I (101)', 'MnS Spell', '+10 Spirit TD, +10 Bolt DS',  'TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|DS_Bolt|Spellburst',  'NONE',  'Calculate_101',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit Barrier (102)', 'MnS Spell', '+20 DS/UDF, -20 Melee AS/UAF\n+1 DS/UDF and -1 Melee AS/UAF per 2 Spell Research, Minor Spiritual ranks above 2 up to character level\n+1 mana cost per 6 Spell Research, Minor Spirit ranks above 2 up to character level',  'DS_All|AS_Melee|UAF|UDF|Spellburst|Mana_Cost',  'Spell Research, Minor Spiritual ranks:303', 'Calculate_102',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit Defense (103)', 'MnS Spell', '+10 DS',  'DS_All|Spellburst',  'NONE',  'Calculate_103',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Disease Resistance (104)', 'MnS Spell', 'Extra warding attempt against Disease\n+1 TD bonus on extra warding attempt per 2 Spiritual Lore, Blessings ranks',  'TD_Spiritual|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_104',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Poison Resistance (105)', 'MnS Spell', 'Extra warding attempt against Posion\n+2 TD bonus on extra warding attempt per summation seed 1 for Spiritual Lore, Blessings ranks',  'TD_Spiritual|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_105',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit Warding II (107)', 'MnS Spell', '+15 Spirit TD, +25 Bolt DS',  'TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|DS_Bolt|Spellburst',  'NONE',  'Calculate_107',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Water Walking (112)', 'MnS Spell', 'Bonus when interacting with water',  'Spellburst',  'NONE',  'Calculate_112',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"Fasthr's Reward (115)\", 'MnS Spell', 'Chance for extra warding attempt',  'Spellburst',  'NONE',  'Calculate_115',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit Strike (117)', 'MnS Spell', '+75 AS on next melee, ranged, bolt, or UAF attack',  'AS_All|UAF|Spellburst',  'NONE',  'Calculate_117',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Lesser Shroud (120)', 'MnS Spell', '+15 DS, +20 Spirit TD\n+1 DS 2 Spell Research, Minor Spiritual ranks above 20 up to character level\n+1 mana cost per 6 Spell Research, Minor Spirit ranks above 2 up to character level',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst|Mana_Cost',  'Spell Research, Minor Spiritual ranks:303',  'Calculate_120',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Wall of Force (140)', 'MnS Spell', '+100 DS',  'DS_All|Spellburst',  'NONE',  'Calculate_140',  'NONE' ) "

      # Major Spiritual (200s)
      db.execute "INSERT INTO Effects VALUES('Spirit Shield (202)', 'MjS Spell', '+10 DS\nIf self cast, +1 DS per 2 Spell Research, Major Spiritual ranks above 2 up to character level\n+1 mana cost per 9 Spell Research, Major Spiritual ranks above 2 up to character level',  'DS_All|Spellburst|Mana_Cost',  'Spell Research, Major Spiritual ranks:303',  'Calculate_202',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Unpresence (204)', 'MjS Spell', 'Aides in hiding and avoiding detection spells',  'Spellburst',  'NONE',  'Calculate_204',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Tend Lore (206)', 'MjS Spell', '+20 phantom First Aid ranks\n+1 phantom First Aid rank per seed 2 summation for Spiritual Lore, Blessing ranks',  'Skill_Phantom_Ranks_First_Aid|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_206',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Purify Air (207)', 'MjS Spell', 'Protects generally against any gaseous effect and maneuver',  'Spellburst',  'NONE',  'Calculate_207',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Bravery (211)', 'MjS Spell', '+15 melee AS, ranged AS, bolt AS, and UAF\n+3 phantom levels against sheer fear',  'AS_All|UAF|Sheer_Fear|Spellburst',  'NONE',  'Calculate_211',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Heroism (215)', 'MjS Spell', '+25 melee AS, ranged AS, bolt AS, and UAF\n+3 phantom levels against sheer fear\n+1 Mana and Health per minute\nCan cast a group version with a 1 minute duration at 65 Spiritual Lore, Blessing ranks\n+1 AS when self-cast for every 10 Spiritual Lore, Blessing ranks',  'AS_All|UAF|Sheer_Fear|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_215',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spell Shield (219)', 'MjS Spell', '+30 bolt DS\n+30 Spirit TD',  'DS_Bolt|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst',  'NONE',  'Calculate_219',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spriti Slayer (240)', 'MjS Spell', 'Spell is recast with a +25 bonus to Bolt AS or Spiritual CS\n+1 Bolt AS and Spiritual CS per summation 5 seed of Spiritual Mana Control ranks',  'AS_Bolt|CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer|Spellburst',  'Spiritual Mana Control ranks:303',  'Calculate_240',  'NONE' ) "

      # Cleric Base (300s)
      db.execute "INSERT INTO Effects VALUES('Prayer of Protection (303)', 'Clrc Spell', '+10 all DS\n+1 DS per 2 Spell Research, Cleric ranks above 3 up to character level or 99 ranks\n+1 mana cost per 6 Spell Research, Cleric ranks above 2 up to character level or 99 ranks',  'DS_All|Spellburst',  'Spell Research, Cleric ranks:303',  'Calculate_303',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Benediction (307)', 'Clrc Spell', '+5 all AS. This increases by 1 for every two Cleric Base ranks trained past rank 7 with a maximum bonus of +15 AS at rank 27\nAdditionally, there is a +1 bolt AS bonus that is self-cast only for every two ranks past rank 27. The maximum bolt AS bonus is +51 at level 99 with 99 spell ranks\n+5 melee and ranged DS at spell rank 7. This increases by 1 for every two Cleric Base ranks trained past rank 7 with a maximum bonus of +15 DS at rank 27\n +1 additional mana cost per bonus point past rank 7. The maximum cost is 53 mana at level 99 with 99 spell ranks\nChance for the group to receive a +15 AS bonus on a given attack at a chance of 1% per seed 6 summation of Spiritual Lore, Blessing ranks',  'DS_Melee|DS_Ranged|AS_Melee|AS_Ranged|AS_Bolt|UAF|Mana_Cost',  'Spell Research, Cleric ranks:303|Spiritual Lore, Blessings ranks:202',  'Calculate_307',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Warding Sphere (310)', 'Clrc Spell', '+10 DS, +10 Spirit TD\n+1 DS, Spirit TD, and Mana Cost per Spell Research, Cleric rank above 10 to a maximum of +20 at 20 ranks',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Mana_Cost',  'Spell Research, Cleric ranks:303',  'Calculate_310',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Prayer (313)', 'Clrc Spell', '+10 Spirit TD\n+10 all DS at 35 Spell Research, Cleric ranks and increases by +1 per rank above 35 up to character level\n+1 mana cost per 6 Spell Research, Minor Spirit ranks above 35 up to character level',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Mana_Cost|Manuever_Defense|Spellburst',  'Spell Research, Cleric ranks:303',  'Calculate_313',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Relieve Burden (314)', 'Clrc Spell', 'Ignore 10,000 silver when calculating encumbrance',  'Spellburst',  'NONE',  'Calculate_314',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Soul Ward (319)', 'Clrc Spell', 'Protective barrier negates attacks and maneuvers',  'Spellburst',  'NONE',  'Calculate_319',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Symbol of the Proselyte (340)', 'Clrc Spell', 'Increases Bolt AS and Spiritual CS by 5 + (Influence bonus / 2)',  'AS_Bolt|CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_340',  'Influence Bonus|Wisdom Bonus' ) "
      db.execute "INSERT INTO Effects VALUES('Symbol of the Proselyte (340) 2', 'Clrc Spell', 'Increases Bolt AS and Spiritual CS against opposite alignment\nby 5 + (Influence bonus / 2) + (Wisdom bonus / 3)',  'AS_Bolt|CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_340_2',  'Influence Bonus|Wisdom Bonus' ) "

      # Minor Elemental (400s)
      db.execute "INSERT INTO Effects VALUES('Elemental Defense I (401)', 'MnE Spell', '+5 all DS, +5 Elemental TD',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst',  'NONE',  'Calculate_401',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Presence (402)', 'MnE Spell', 'Finds hidden people and creatures and aides in perception related tasks',  'Spellburst',  'NONE',  'Calculate_402',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Lock Pick Enhancement (403)', 'MnE Spell', 'Bonus on picking locked boxes',  'Spellburst',  'NONE',  'Calculate_403',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Disarm Enhancement (404)', 'MnE Spell', 'Bonus on disarming trapped boxes',  'Spellburst',  'NONE',  'Calculate_404',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Defense II (406)', 'MnE Spell', '+10 all DS, +10 Elemental TD',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst',  'NONE',  'Calculate_406',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Defense III (414)', 'MnE Spell', '+20 all DS, +15 Elemental TD',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst',  'NONE',  'Calculate_414',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mana Focus (418)', 'MnE Spell', '+10 mana regeneration',  'Resource_Recovery_Mana_Normal',  'NONE',  'Calculate_418',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Targeting (425)', 'MnE Spell', '+25 all AS, UAF and Elemental CS\n+1 all AS, UAF and Elemental CS per 2 Spell Research, Minor Elemental ranks above 25 up to a +50 at 75 ranks',  'AS_All|UAF|CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer|Spellburst',  'Spell Research, Minor Elemental ranks:303',  'Calculate_425',  '425 CS' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Barrier (430)', 'MnE Spell', '+15 all DS and Elemental TD\n+1 all DS and Elemental TD per 2 Spell Research, Minor Elemental ranks above 30',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|CS_Elemental|Spellburst',  'Spell Research, Minor Elemental ranks:303',  'Calculate_430',  'NONE' ) "

      # Major Elemental (500s)
      db.execute "INSERT INTO Effects VALUES(\"Thurfel\'s Ward (503)\", 'MjE Spell', '+20 all DS\n+1 all DS when self-cast per 4 Spell Research, Major Elemental ranks above 3\n+1 Mana Cost per 12 Spell Research, Major Elemental rank above 3\nTraining in Elemental Lore, Earth will give a chance of seed 10 summation of ranks to gain an additional +20 DS on any single attack',  'DS_All|Spellburst|Mana_Cost',  'Spell Research, Major Elemental ranks:303|Elemental Lore, Earth ranks:202',  'Calculate_503',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Deflection (507)', 'MjE Spell', '+20 all DS\n+1 all DS per 2 Spell Research, Major Elemental ranks above 7\n+1 Mana Cost per 12 Spell Research, Major Elemental rank above 7',  'DS_All|Spellburst|Mana_Cost',  'Spell Research, Major Elemental ranks:303',  'Calculate_507',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Celerity (506)', 'MjE Spell', 'Reduces combat roundtime',  'Roundtime_Reduction|Spellburst',  'Elemental Lore, Air ranks:202',  'Calculate_506',  'Stamina Cost' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Bias (508)', 'MjE Spell', '+20 elemental TD',  'TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst',  'NONE',  'Calculate_508',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Strength (509)', 'MjE Spell', '+15 melee AS, UAF, encumbrance reduction, strength bonus for reducing ranged roundtime\n+1 melee AS, UAF when self-cast per seed 4 summation of Elemental Lore, Earth ranks',  'AS_Melee|UAF|Encumbrance_Reduction_Percent|Roundtime_Strength|Spellburst',  'Elemental Lore, Earth ranks:202',  'Calculate_509',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Focus (513)', 'MjE Spell', '+20 bolt AS\n+1 bolt AS when self-cast per 2 Spell Research, Major Elemental ranks above 13 capped at character level\nAdditional bolt spell cast at the same target will cause a flare that increases bolt AS',  'AS_Bolt|Spellburst',  'Spell Research, Major Elemental ranks:303',  'Calculate_513',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mage Armor (520) Air', 'MjE Spell', 'Various bonus to based on elemental type\nAir: +10 carrying capacity. +1 lb per summation seed 1 of Air Lore',  'Encumbrance_Reduction_Absolute|Spellburst',  'Elemental Lore, Air ranks:202',  'Calculate_520_Air',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Temporal Revision (540)', 'MjE Spell', '+200 all DS',  'DS_All|Spellburst',  'NONE',  'Calculate_540',  'NONE' ) "

      # Ranger Base (600s)
      db.execute "INSERT INTO Effects VALUES('Natural Colors (601)', 'Rngr Spell', '+10 all DS\n+1 DS per seed 5 summation of Spiritual Lore, Blessings ranks',  'DS_All|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_601',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Resist Elements (602)', 'Rngr Spell', '+10 fire, ice, and electrical bolt DS\n+1 bolt DS when self-cast per seed 5 summation of Spiritual Lore, Blessings ranks',  'DS_Bolt|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_602',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Foraging (603)', 'Rngr Spell', 'Improves foraging',  'Spellburst',  'NONE',  'Calculate_603',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Skinning (604)', 'Rngr Spell', 'Improves skinning',  'Spellburst',  'NONE',  'Calculate_604',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Whispering Willow (605)', 'Rngr Spell', 'Allows whispering over a long distance',  'Spellburst',  'NONE',  'Calculate_605',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"Phoen\'s Strength (606)\", 'Rngr Spell', '+10 melee AS, UAF, encumbrance reduction, strength bonus for reducing ranged roundtime',  'AS_Melee|UAF|Encumbrance_Reduction_Percent|Roundtime_Strength|Spellburst',  'NONE',  'Calculate_606',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Camouflage (608)', 'Rngr Spell', '+30 all AS, UAF on next attack',  'AS_All|UAF|Spellburst',  'NONE',  'Calculate_608',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Self Control (613)', 'Rngr Spell', '+20 melee DS, Spiritual TD\n+1 Spiritual TD per seed 5 summation of Spiritual Lore, Blessings ranks\n+1 melee DS per 2 Spell Research, Ranger Base ranks above 13 capped at +63',  'DS_Melee|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst',  'Spell Research, Ranger ranks:202|Spiritual Lore, Blessings ranks:202',  'Calculate_613',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sneaking (617)', 'Rngr Spell', 'Improves hiding and sneaking',  'Spellburst',  'NONE',  'Calculate_617',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mobility (618)', 'Rngr Spell', '+20 phantom Dodging ranks\n+1 phantom Dodging rank per Spell Research, Ranger Base rank over 18\n+1 Mana Cost per 4 Spell Research, Ranger Base ranks above 18',  'Skill_Phantom_Ranks_Dodging|Spellburst|Mana_Cost',  'Spell Research, Ranger ranks:202',  'Calculate_618',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"Nature\'s Touch (625)\", 'Rngr Spell', 'May cast Ranger spells indoors at full power\n+1 Spiritual TD\n+1 Spiritual TD per 2 Spell Research, Ranger Base ranks over 25 up to a maximum of a +12 bonus to TD at 49 rank',  'TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst',  'Spell Research, Ranger ranks:202',  'Calculate_625',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Wall of Thorns (640)', 'Rngr Spell', '+20 all DS\ngrants a 20% chance of the thorns blocking an incoming attack completely\n25% chance of poisoning the attacker on a successful block',  'DS_All|Spellburst',  'NONE',  'Calculate_640',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Assume Aspect (650) Bear', 'Rngr Spell', '+20 increase to Constitution stat\nIncrease maximum Health by +25\n+1 increase to Constitution stat per seed 2 summation of Spiritual Lore, Blessings ranks\n+1 increase to max Health per seed 1 summation of Spiritual Lore, Summoning ranks',  'Statistic_Constitution|Resource_Maximum_Health|Spellburst',  'Spiritual Lore, Blessings ranks:202|Spiritual Lore, Summoning ranks:202',  'Calculate_650_Bear',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Assume Aspect (650) Hawk', 'Rngr Spell', '+20 Perception ranks\n+1 Perception rank per seed 2 summation of Spiritual Lore, Summoning ranks',  'Skill_Ranks_Perception|Spellburst',  'Spiritual Lore, Summoning ranks:202',  'Calculate_650_Hawk',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Assume Aspect (650) Jackal', 'Rngr Spell', '+20 Ambush ranks\n+1 Ambush rank per seed 2 summation of Spiritual Lore, Summoning ranks',  'Skill_Ranks_Ambush|Spellburst',  'Spiritual Lore, Summoning ranks:202',  'Calculate_650_Jackal',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Assume Aspect (650) Lion', 'Rngr Spell', '+20 increase to Influence and Strength stats\n+1 increase to Influence and Strength stats per seed 2 summation of Spiritual Lore, Blessings ranks',  'Statistic_Influence|Statistic_Strength|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_650_Lion',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Assume Aspect (650) Owl', 'Rngr Spell', '+20 increase to Aura and Wisdom stats\n+1 increase to Aura and Wisdom stats per seed 2 summation of Spiritual Lore, Blessings ranks',  'Statistic_Aura|Statistics_Wisdom|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_650_Owl',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Assume Aspect (650) Porcupine', 'Rngr Spell', '+20 increase to Logic stat\n+1 increase to Logic stat per seed 2 summation of Spiritual Lore, Blessings ranks',  'Statistic_Logic|Spellburst',  'Spiritual Lore, Blessings ranks:202|Spiritual Lore, Summoning ranks:202',  'Calculate_650_Porcupine',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Assume Aspect (650) Rat', 'Rngr Spell', '+20 increase to Agility and Discipline stats ranks\n+1 increase to Agility and Discipline stats per seed 2 summation of Spiritual Lore, Blessings ranks',  'Statistic_Agility|Statistic_Discipline|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_650_Rat',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Assume Aspect (650) Wolf', 'Rngr Spell', '+20 increase to Dexterity and Intuition stats\n+1 increase to Dexterity and Intuition stats per seed 2 summation of Spiritual Lore, Blessings ranks',  'Statistic_Dexterity|Statistic_Intuition|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_650_Wolf',  'NONE' ) "
      #db.execute "INSERT INTO Effects VALUES('Assume Aspect (650) Yierka', 'Rngr Spell', '+20 Survival ranks\n+1 Survival rank per seed 2 summation of Spiritual Lore, Summoning ranks',  'Skill_Ranks_Surival|Spellburst',  'Spiritual Lore, Summoning ranks:202',  'Calculate_650_Yierka',  'Aspect Yierka' ) "

      # Sorcerer Base (700s)
      db.execute "INSERT INTO Effects VALUES('Cloak of Shadows (712)', 'Sorc Spell', '+25 all DS, +20 Sorcerer TD\n+1 all DS per Spell Research, Sorcerer Base rank above 12 capped at +88 DS (+113 total)\n+1 Sorcerer TD per 10 Spell Research, Sorcerer Base ranks above 12 capped at +8 DS (+28 total)\n+1 Mana Cost per 3 Spell Research, Sorcerer Base rank above 12',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst|Mana_Cost',  'Spell Research, Sorcerer ranks:303',  'Calculate_712',  'NONE' ) "

      # Wizard Base (900s)
      db.execute "INSERT INTO Effects VALUES('Minor Elemental Edge (902) EVOKE', 'Wiz Spell', '+10 skill bonus to a specific weapon type\n+1 skill bonus per seed 7 summation of Elemental Lore, Earth ranks',  'Skill_Bonus_Brawling|Skill_Bonus_Edged_Weapons|Skill_Bonus_Blunt_Weapons|Skill_Bonus_Two-Handed_Weapons|Skill_Bonus_Ranged_Weapons|Skill_Bonus_Thrown_Weapons|Skill_Bonus_Polearm_Weapons',  'Elemental Lore, Earth ranks:202',  'Calculate_902',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Prismatic Guard (905)', 'Wiz Spell', '+5 melee and ranged DS, +20 bolt DS\n+1 all DS per seed 5 summation of Elemental Lore, Earth ranks\n+1 all DS per 4 Spell Research, Wizard Base ranks over 5\n+1 Mana Cost per 15 Spell Research, Wizard Base ranks above 5',  'DS_Melee|DS_Ranged|DS_Bolt|Spellburst|Mana_Cost',  'Spell Research, Wizard ranks:303|Elemental Lore, Earth ranks:202',  'Calculate_905',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mass Blur (911)', 'Wiz Spell', '+20 phantom Dodging ranks\n+1 phantom Dodging rank for the caster only per seed 1 summation of Elemental Lore, Air ranks',  'Skill_Phantom_Ranks_Dodging|Spellburst|Mana_Cost',  'Elemental Lore, Air ranks:202',  'Calculate_911',  'ignore_enhancive_limit' ) "
      db.execute "INSERT INTO Effects VALUES(\"Melgorehn\'s Aura (913)\", 'Wiz Spell', '+10 all DS, +20 Elemental TD\n+1 all DS per Spell Research, Wizard Base rank above 13\n+1 Elemental TD per 3 Spell Research, Wizard Base ranks above 13\n+1 Mana Cost per 3 Spell Research, Wizard Base rank above 13',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst|Mana_Cost',  'Spell Research, Wizard ranks:303',  'Calculate_913',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Invisiblity (916)', 'Wiz Spell', 'Turn invisible',  'Spellburst',  'NONE',  'Calculate_916',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"Wizard\'s Shield (919)\", 'Wiz Spell', '+50 DS',  'DS_All|Spellburst',  'NONE',  'Calculate_919',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Core Tap (950)', 'Wiz Spell', 'Spells cast with Core Tap have increased Bolt AS and Elemental CS\nAS Bolt = 6 * bonus per seed 10 summation of Elemental Lore, Fire ranks\nElemental CS = 6 * 3/5 * bonus per seed 10 summation of Elemental Lore, Fire ranks',  'AS_Bolt|CS_Elemental',  'Elemental Lore, Fire ranks:202',  'Calculate_950',  'NONE' ) "

      # Bard Base (1000s)
      db.execute "INSERT INTO Effects VALUES('Fortitude Song (1003)', 'Spellsong', '+10 all DS',  'DS_All',  'NONE',  'Calculate_1003',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"Kai\'s Triumph Song (1007)\", 'Spellsong', '+10 all AS\n+1 all AS per Spell Research, Bard Base rank above 7 capped at +20\n+1 all AS per seed 3 summation of Mental Lore, Telepathy ranks\nMaximum AS provided is capped at +31',  'AS_All|UAF',  'Spell Research, Bard ranks:202|Mental Lore, Telepathy ranks:202', 'Calculate_1007', 'NONE'  ) "
      db.execute "INSERT INTO Effects VALUES('Song of Valor (1010)', 'Spellsong', '+10 all DS\n+1 all DS per 2 Spell Research, Bard Base ranks above 10\n+1 Mana Cost per 2 Spell Research, Bard Base rank above 13',  'DS_All',  'Spell Research, Bard ranks:202',  'Calculate_1010',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Song of Mirrors (1019)', 'Spellsong', '+20 phantom Dodging ranks\n+1 phantom Dodging rank per 2 Spell Research, Bard Base ranks over 19\n+1 Mana Cost per 5 Spell Research, Bard Base ranks above 19',  'Skill_Phantom_Ranks_Dodging|Mana_Cost',  'Spell Research, Bard ranks:202',  'Calculate_1019',  'ignore_enhancive_limit' ) "
      db.execute "INSERT INTO Effects VALUES('Song of Tonis (1035)', 'Spellsong', '+20 phantom Dodging ranks, -1 Haste effect\n+1 phantom Dodging rank at the following Elemental Lore, Air rank inverals: 1,2,3,5,8,10,14,17,21,26,31,36,42,49,55,63,70,78,87,96\nHaste effect improves to -2 at Elemental Lore, Air rank 30 and -3 at Elemental Lore, Air rank 75\nThe bonus is +1 second per rank for the first 20 ranks of ML, Telepathy. Every 2 lore ranks thereafter will increase the spellsong duration +1 second. The maximum duration (base + lore bonus) with 100 ranks of ML, Telepathy is 120 seconds.',  'Skill_Phantom_Ranks_Dodging|Roundtime_Reduction',  'Elemental Lore, Air ranks:202|Mental Lore, Telepathy ranks:202',  'Calculate_1035',  'NONE' ) "

      # Empath Base (1100s)
      db.execute "INSERT INTO Effects VALUES('Empathic Focus (1109)', 'Emp Spell', '+15 Spiritual TD, +25 all DS, +15 melee AS\n+1 all DS per 2 Spell Research, Empath Base ranks above 9\n+1 Mana Cost per 6 Spell Research, Empath Base rank above 9',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|AS_Melee|UAF|Spellburst|Mana_Cost',  'Spell Research, Empath ranks:202',  'Calculate_1109',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Strength of Will (1119)', 'Emp Spell', '+12 Spirtual TD, +12 all DS\n+1 all DS and Spiritual TD per 3 Spell Research, Empath Base ranks above 19\n+1 Mana Cost per 9 Spell Research, Empath Base rank above 19',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst|Mana_Cost',  'Spell Research, Empath ranks:202',  'Calculate_1119',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Intensity (1130)', 'Emp Spell', '+20 all DS, +20 all AS\n+1 all DS and all AS per 2 Spell Research, Empath Base ranks above 30\n+1 Mana Cost per 6 Spell Research, Empath Base rank above 30',  'DS_All|AS_All|Spellburst|Mana_Cost',  'Spell Research, Empath ranks:202',  'Calculate_1130',  'NONE' ) "

      # Minor Mental (1200s)
      db.execute "INSERT INTO Effects VALUES('Iron Skin (1202)', 'MnM Spell', 'Gives ASG when unarmored',  'Spellburst',  'NONE',  'Calculate_1202',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Foresight (1204)', 'MnM Spell', '+10 melee and ranged DS',  'DS_Melee|DS_Ranged|Spellburst',  'NONE',  'Calculate_1204',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mindward (1208)', 'MnM Spell', '+20 Mental TD\n+1 Mental TD 2 Spell Research, Minor Mental ranks above 8 to a maximum of +40\n+1 Mana Cost per 4 Spell Research, Minor Mental rank above 8',  'TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst|Mana_Cost',  'Spell Research, Minor Mental ranks:303',  'Calculate_1208',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Dragonclaw (1209)', 'MnM Spell', '+10 UAF\n+1 UAF per seed 1 for Mental Lore, Transformation ranks',  'UAF|Spellburst',  'Mental Lore, Transformation ranks:202',  'Calculate_1209',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Blink (1214)', 'MnM Spell', 'Extra chance to dodge attacks',  'Spellburst',  'NONE',  'Calculate_1214',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Focus Barrier (1216)', 'MnM Spell', '+30 all DS',  'DS_All',  'NONE',  'Calculate_1216',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Premonition (1220)', 'MnM Spell', '+20 all DS\n+1 all DS per 2 Spell Research, Minor Mental ranks above 20\n+1 Mana Cost per 4 Spell Research, Minor Mental rank above 20',  'DS_All|Spellburst|Mana_Cost',  'Spell Research, Minor Mental ranks:303',  'Calculate_1220',  'NONE' ) "

      # Paladin Base (1600s)
      db.execute "INSERT INTO Effects VALUES('Mantle of Faith (1601)', 'Pala Spell', '+5 all DS, +5 Spiritual TD\n+1 all DS and Spiritual TD per seed 2 summation of Spiritual Lore, Blessings ranks\n+1 Mana Cost per +1 DS/TD increase',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_1601',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"Faith\'s Clarity (1603)\", 'Pala Spell', '-5% spiritual spell hindrance\nAdditional -1% spiritual spell hindrance per 3 Spiritual Lore, Summoning ranks to a maximum of -5% (-10% total)',  'Spell_Hindrance_Spiritual|Spellburst',  'Spiritual Lore, Summoning ranks:202',  'Calculate_1603',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Arm of the Arkati (1605)', 'Pala Spell', 'Increase base attack factor of weapons',  'Spellburst',  'NONE',  'Calculate_1605',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Dauntless (1606)', 'Pala Spell', '+10 all AS\n+3 phantom level against sheer fear',  'AS_All|UAF|Sheer_Fear|Spellburst',  'NONE',  'Calculate_1606',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Rejuvanation (1607)', 'Pala Spell', 'Increases stamina recovery by 10% max stamina. +3 stamina per summation seed 1 of Spiritual Lore, Blessings\n -1% every 30 seconds. Use the tier field to represent this. Tier 1 = 10%, Tier 9 = 1%',  'Resource_Recovery_Stamina|Spellburst',  'Spiritual Lore, Blessings ranks:202|Tier:1-9',  'Calculate_1607',  'Maximum Stamina' ) "
      db.execute "INSERT INTO Effects VALUES('Beacon of Courage (1608)', 'Pala Spell', '+1 enemy ignored in Force on Force.\n+1 additional enemy ignored per seed 10 summation of Spiritual Lore, Blessings ranks',  'Force_On_Force|Spellburst',  'Spiritual Lore, Blessings ranks:202',  'Calculate_1608',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Higher Vision (1610)', 'Pala Spell', '+10 all DS\n+1 all DS per 2 Spell Research, Paladin Base ranks above 10 to a maximum of +20\n+1 Mana Cost per 2 Spell Research, Paladin Base ranks above 10\n+1 all DS per seed 5 summation of Spiritual Lore, Religion ranks\n+1 Mana Cost per 2 Spell Research, Paladin Base rank above 20',  'DS_All|Spellburst|Mana_Cost',  'Spell Research, Paladin ranks:202|Spiritual Lore, Religion ranks:202',  'Calculate_1610',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"Patron\'s Blessing (1611)\", 'Pala Spell', '+10 phantom Combat Maneuver ranks\n+1 Combat Maneuver rank per seed 3 summation of Spiritual Lore, Blessings ranks\n+0.75 Combat Maneuver rank per 2 Spell Research, Paladin Base rank above 11\n+1 Mana Cost per 4 Spell Research, Paladin Base rank above 11',  'Skill_Phantom_Ranks_Combat_Maneuvers|Spellburst|Mana_Cost',  'Spell Research, Paladin ranks:202|Spiritual Lore, Blessings ranks:202',  'Calculate_1611',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"Champion\'s Might (1612)\", 'Pala Spell', '+15 Spiritual CS\n+1 Spiritual CS per 1 Spell Research, Paladin Base rank above 12 to a maximum of +10 (+25 total)',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer|Spellburst',  'Spell Research, Paladin ranks:202',  'Calculate_1612',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Guard the Meek (1613) Group', 'Pala Spell', '+15 melee DS\n+1 melee DS per 5 Spell Research, Paladin Base ranks above 18 to a maximum of +20\n+1 all DS per seed 6 summation of Spiritual Lore, Blessings ranks (max of +5 at 40 ranks',  'DS_Melee',  'Spell Research, Paladin ranks:202',  'Calculate_1613_Group',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Guard the Meek (1613) Self', 'Pala Spell', '+15 melee DS\n+1 all DS per seed 6 summation of Spiritual Lore, Blessings ranks (max of +5 at 40 ranks)',  'DS_Melee',  'Spiritual Lore, Blessings ranks:202',  'Calculate_1613_Self',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Vigor (1616)', 'Pala Spell', '+4 Constitution statistic and +8 maximum health.\n+1 Constitution statistic and +2 maximum health per 4 Spell Research, Paladin Base rank above 16 to a maximum of +10 and +20 at 40 ranks.\nAdditional maximum health equal to square root of 2 * Spiritual Lore, Blessings bonus',  'Statistic_Constitution|Resource_Maximum_Health|Spellburst',  'Spell Research, Paladin ranks:202|Spiritual Lore, Blessings ranks:202',  'Calculate_1616',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Zealot (1617)', 'Pala Spell', '+30 melee AS, -30 all DS\n+1 melee AS and all DS per seed 1 summation of Spiritual Lore, Religion ranks',  'DS_All|AS_Melee|UAF',  'Spiritual Lore, Religion ranks:202',  'Calculate_1617',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Faith Shield (1619)', 'Pala Spell', '+50 Spiritual TD\n+3 Spiritual TD per seed 5 summation of Spiritual Lore, Religion ranks',  'DS_All|TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer|Spellburst',  'Spiritual Lore, Religion ranks:202',  'Calculate_1619',  'NONE' ) "

      # Arcane (1700s)
      db.execute "INSERT INTO Effects VALUES('Mystic Focus (1711)', 'Arc Spell', '+10 all CS',  'CS_All',  'NONE',  'Calculate_1711_AS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mystic Focus (1711) Arcane Symbols', 'Arc Spell', '+10 all CS\nGrants +25 additional CS for non-native elemental circles if spell is from a scroll at 25 Arcane Symbols ranks.\n+1 for every 2 Arcane Symbols ranks over 25 up to a maximum of +50 at 75 ranks.',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_1711_AS',  '1711 AS' ) "
      db.execute "INSERT INTO Effects VALUES('Mystic Focus (1711) Magic Item Use', 'Arc Spell', '+10 all CS\nGrants +25 additional CS for non-native elemental circles if spell is from a magic item at 25 Magic Item Use ranks\n+1 for every 2 Magic Item Use  ranks over 25 up to a maximum of +50 at 75 ranks',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_1711_MIU',  '1711 MIU' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit Guard (1712)', 'Arc Spell', '+25 all DS',  'DS_All',  'NONE',  'Calculate_1712',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"V\'tull\'s Fury (1718)\", 'Arc Spell', '+30 melee AS',  'AS_Melee',  'NONE',  'Calculate_1718',  'NONE' ) "

      # Effects related to Combat, Shield, or Armor Maneuvers
      db.execute "INSERT INTO Effects VALUES('Armor Blessing', 'Maneuver', 'Increases bolt AS, all CS for one cast after spell failure by (3 * AG * Blessing Rank) = AS bonus or ((3* AG * Blessing Rank) * 3/5) = CS bonus',  'AS_Bolt|CS_All',  'Maneuver ranks:1-5',  'Calculate_Armor_Blessing',  'Armor Group' ) "
      db.execute "INSERT INTO Effects VALUES('Armored Evasion', 'Maneuver', 'Reduces Armor Action Penalty by [Rank * (7 - Armor Group of worn armor)] / 2',  'Action_Penalty',  'Maneuver ranks:1-5',  'Calculate_Armored_Evasion',  'Armor Group' ) "
      db.execute "INSERT INTO Effects VALUES('Armored Fluidity', 'Maneuver', 'Reduces the base Spell Hinderance of Armor by 10% per rank',  'Spell_Hindrance_All',  'Maneuver ranks:1-5',  'Calculate_Armored_Fluidity',  'Armor Base Hindrance' ) "
      db.execute "INSERT INTO Effects VALUES('Armor Support', 'Maneuver', ' Reduces encumbrance by a number of pounds equal to 5 + ((Armor Group of worn armor + 1) * Rank)',  'Encumbrance_Reduction_Absolute',  'Maneuver ranks:1-5',  'Calculate_Armor_Support',  'Armor Group' ) "
      db.execute "INSERT INTO Effects VALUES('Berserk', 'Maneuver', 'AS bonus equal to (guild/cman ranks - 1 + (level/4) - 20) / 2. Max AS bonus is +29',  'AS_Melee',  'Guild skill ranks:1-63|Maneuver ranks:1-5',  'Calculate_Berserk',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Burst of Swiftness', 'Maneuver', '+6 increase to Agility bonus and +3 increase to Dexterity\n+2 Agility and +1 Dexterity per rank above 1',  'Statistic_Bonus_Dexterity|Statistic_Bonus_Agility',  'Maneuver ranks:1-5',  'Calculate_Burst_of_Swiftness',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Combat Focus', 'Maneuver', '+2 all TD per rank',  'TD_All',  'Maneuver ranks:1-5',  'Calculate_Combat_Focus',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Combat Movement', 'Maneuver', '+2 melee and ranged DS per rank',  'DS_Melee|DS_Ranged',  'Maneuver ranks:1-5',  'Calculate_Combat_Movement',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Combat Toughness', 'Maneuver', '+5 bonus to maximum health.\n+10 additional maximum health per rank',  'Resource_Maximum_Health',  'Maneuver ranks:1-3',  'Calculate_Combat_Toughness',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Coup de Grace (Buff)', 'Maneuver', '+10 to +40 all AS',  'AS_All',  'All AS bonus:1-40',  'Calculate_Coup_de_Grace_Buff',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Perfect Self', 'Maneuver', '+2/+4/+6/+8/+10 to all statistic bonuses',  'Statistic_Bonus_Strength|Statistic_Bonus_Constitution|Statistic_Bonus_Dexterity|Statistic_Bonus_Agility|Statistic_Bonus_Discipline|Statistic_Bonus_Aura|Statistic_Bonus_Logic|Statistic_Bonus_Intuition|Stat_BonusWisdom|Statistic_Bonus_Influence',  'Maneuver ranks:1-5',  'Calculate_Perfect_Self',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Shield Forward', 'Maneuver', '+10 enhancive Shield Use ranks per maneuver rank',  'Skill_Ranks_Shield_Use',  'Maneuver ranks:1-3',  'Calculate_Shield_Forward',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Shield Swiftness', 'Maneuver', '+0.04 increase per rank to Shield Factor when using a Small or Medium shield',  'Shield_Factor',  'Maneuver ranks:1-3',  'Calculate_Shield_Swiftness',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Specialization I', 'Maneuver', '+2 AS per rank',  'AS_Melee|AS_Ranged|UAF',  'Maneuver ranks:1-5',  'Calculate_Specialization_I',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Specialization II', 'Maneuver', '+2 AS per rank',  'AS_Melee|AS_Ranged|UAF',  'Maneuver ranks:1-5',  'Calculate_Specialization_II',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Specialization III', 'Maneuver', '+2 AS per rank',  'AS_Melee|AS_Ranged|UAF',  'Maneuver ranks:1-5',  'Calculate_Specialization_III',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spin Attack', 'Maneuver', '+3 all AS and Dodging bonus per rank',  'AS_Melee|Skill_Bonus_Dodging',  'Maneuver ranks:1-5',  'Calculate_Spin_Attack',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Surge of Strength', 'Maneuver', '+8/+10/+12/+14/+16 increase to Strength bonus',  'Statistic_Bonus_Strength',  'Maneuver ranks:1-5',  'Calculate_Surge_of_Strength',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"War Cries - Seanette\'s Shout\", 'Maneuver', '+15 AS to group but not to self',  'AS_All|UAF',  'NONE',  'Calculate_War_Cries_Shout',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"War Cries - Horland\'s Holler\", 'Maneuver', '+20 AS to group including self',  'AS_All|UAF',  'NONE',  'Calculate_War_Cries_Holler',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Weapon Bonding', 'Maneuver', '+2 AS per rank',  'AS_Melee|AS_Ranged|UAF',  'Maneuver ranks:1-5',  'Calculate_Weapon_Bonding',  'NONE' ) "

      # Effects related to Society powers
      db.execute "INSERT INTO Effects VALUES('Sigil of Concentration', 'Society', '+5 mana regeneration',  'Resource_Recovery_Mana_Normal',  'NONE',  'Calculate_Sigil_of_Concentration',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sigil of Defense', 'Society', '+1 DS per GoS rank',  'DS_All',  'Guardians of Sunfist rank:0-20',  'Calculate_Sigil_of_Defense',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sigil of Focus', 'Society', '+1 TD per GoS rank',  'TD_All',  'Guardians of Sunfist rank:0-20',  'Calculate_Sigil_of_Focus',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sigil of Major Bane', 'Society', '+10 AS, +10 UAF',  'AS_All|UAF',  'NONE',  'Calculate_Sigil_of_Major_Bane',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sigil of Major Protection', 'Society', '+10 DS',  'DS_All',  'NONE',  'Calculate_Sigil_of_Major_Protection',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sigil of Mending', 'Society', '+15 health recovery',  'Resource_Recovery_Health',  'NONE',  'Calculate_Sigil_of_Mending',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sigil of Minor Bane', 'Society', '+5 AS, +5 UAF',  'AS_All|UAF',  'NONE',  'Calculate_Sigil_of_Minor_Bane',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sigil of Minor Protection', 'Society', '+5 DS',  'DS_All',  'NONE',  'Calculate_Sigil_of_Minor_Protection',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sigil of Offense', 'Society', '+1 AS/UAF per GoS rank',  'AS_All|UAF',  'Guardians of Sunfist rank:0-20',  'Calculate_Sigil_of_Offense',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sign of Defending', 'Society', '+10 DS',  'DS_All',  'NONE',  'Calculate_Sign_of_Defending',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sign of Deflection', 'Society', '+20 bolt DS',  'DS_Bolt',  'NONE',  'Calculate_Sign_of_Deflection',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sign of Dissipation', 'Society', '+20 TD',  'TD_All',  'NONE',  'Calculate_Sign_of_Dissipation',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sign of Madness', 'Society', '+50 AS, +50 UAF, -50 DS',  'AS_All|DS_All|UAF',  'NONE',  'Calculate_Sign_of_Madness',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sign of Shields', 'Society', '+20 DS',  'DS_All',  'NONE',  'Calculate_Sign_of_Shields',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sign of Smiting', 'Society', '+10 AS, +10 UAF',  'AS_All|UAF',  'NONE',  'Calculate_Sign_of_Smiting',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sign of Striking', 'Society', '+5 AS, +5 UAF',  'AS_All|UAF',  'NONE',  'Calculate_Sign_of_Striking',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sign of Swords', 'Society', '+20 AS, +20 UAF',  'AS_All|UAF',  'NONE',  'Calculate_Sign_of_Swords',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sign of Warding', 'Society', '+5 DS',  'DS_All',  'NONE',  'Calculate_Sign_of_Warding',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Symbol of Courage', 'Society', '+1 AS and UAF per Voln rank',  'AS_All|UAF',  'Order of Voln rank:0-26',  'Calculate_Symbol_of_Courage',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Symbol of Protection', 'Society', '+1 DS per Voln rank\n+1 TD per 2 Voln ranks',  'DS_All|TD_All',  'Order of Voln rank:0-26',  'Calculate_Symbol_of_Protection',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Symbol of Supremecy', 'Society', '+1 bonus per two Voln ranks to AS/CS,CMAN, UAF against undead creatures',  'AS_All|CS_All|UAF',  'Order of Voln rank:0-26',  'Calculate_Symbol_of_Supremecy',  'NONE' ) "

      # Enhancive effects that increase or improve the recovery of Health, Mana, Stamina, or Spirit.
      db.execute "INSERT INTO Effects VALUES('Health Recovery', 'Enhancive Resource', 'Increases Health Recovery',  'Resource_Recovery_Health',  'Health recovery bonus:1-50',  'Calculate_Enhancive_Resource_Recovery_Health',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mana Recovery', 'Enhancive Resource', 'Increases Mana Recovery',  'Resource_Recovery_Mana',  'Mana recovery bonus:1-50',  'Calculate_Enhancive_Resource_Recovery_Mana',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Stamina Recovery', 'Enhancive Resource', 'Increases Stamina Recovery',  'Resource_Recovery_Stamina',  'Stamina recovery bonus:1-50',  'Calculate_Enhancive_Resource_Recovery_Stamina',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit Recovery', 'Enhancive Resource', 'Increases Spirit Recovery',  'Resource_Recovery_Spirit',  'Spirit recovery bonus:1-3',  'Calculate_Enhancive_Resource_Recovery_Spirit',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Maximum Health', 'Enhancive Resource', 'Increases Maximum Health',  'Resource_Maximum_Health',  'Health maximum bonus:1-50',  'Calculate_Enhancive_Resource_Maximum_Health',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Maximum Mana', 'Enhancive Resource', 'Increases Maximum Mana',  'Resource_Maximum_Mana',  'Mana maximum bonus:1-50',  'Calculate_Enhancive_Resource_Maximum_Mana',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Maximum Stamina', 'Enhancive Resource', 'Increases Maximum Stamina',  'Resource_Maximum_Stamina',  'Stamina maximum bonus:1-50',  'Calculate_Enhancive_Resource_Maximum_Stamina',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Maximum Spirit', 'Enhancive Resource', 'Increases Maximum Spirit',  'Resource_Maximum_Spirit',  'Spirit maximum bonus:1-3',  'Calculate_Enhancive_Resource_Maximum_Spirit',  'NONE' ) "

      # Enhancive effects that modify character skill ranks or bonuses
      db.execute "INSERT INTO Effects VALUES('Armor Use', 'Enhancive Skill', 'Increases skill bonus/ranks in Armor Use',  'Skill_Bonus_Armor_Use|Skill_Ranks_Armor_Use',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Armor_Use',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Shield Use', 'Enhancive Skill', 'Increases skill bonus/ranks in Shield Use',  'Skill_Bonus_Shield_Use|Skill_Ranks_Shield_Use',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Shield_Use',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Edged Weapons', 'Enhancive Skill', 'Increases skill bonus/ranks in Edged Weapons',  'Skill_Bonus_Edged_Weapons|Skill_Ranks_Edged_Weapons',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Edged_Weapons',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Blunt Weapons', 'Enhancive Skill', 'Increases skill bonus/ranks in Blunt Weapons',  'Skill_Bonus_Blunt_Weapons|Skill_Ranks_Blunt_Weapons',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Blunt_Weapons',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Two-Handed Weapons', 'Enhancive Skill', 'Increases skill bonus/ranks in Two-Handed Weapons',  'Skill_Bonus_Two_Handed_Weapons|Skill_Ranks_Two_Handed_Weapons',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Two_Handed_Weapons',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Ranged Weapons', 'Enhancive Skill', 'Increases skill bonus/ranks in Ranged Weapons',  'Skill_Bonus_Ranged_Weapons|Skill_Ranks_Ranged_Weapons',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Ranged_Weapons',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Thrown Weapons', 'Enhancive Skill', 'Increases skill bonus/ranks in Thrown Weapons',  'Skill_Bonus_Thrown_Weapons|Skill_Ranks_Thrown_Weapons',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Thrown_Weapons',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Polearm Weapons', 'Enhancive Skill', 'Increases skill bonus/ranks in Polearm Weapons',  'Skill_Bonus_Polearm_Weapons|Skill_Ranks_Polearm_Weapons',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Polearm_Weapons',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Brawling', 'Enhancive Skill', 'Increases skill bonus/ranks in Brawling Weapons',  'Skill_Bonus_Brawling|Skill_Ranks_Brawling',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Brawling',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Ambush', 'Enhancive Skill', 'Increases skill bonus/ranks in Ambush',  'Skill_Bonus_Ambush|Skill_Ranks_Ambush',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Ambush',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Two Weapon Combat', 'Enhancive Skill', 'Increases skill bonus/ranks in Two Weapon Combat',  'Skill_Bonus_Two_Weapon_Combat|Skill_Ranks_Two_Weapon_Combat',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Two_Weapon_Combat',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Combat Maneuvers', 'Enhancive Skill', 'Increases skill bonus/ranks in Combat Maneuvers',  'Skill_Bonus_Combat_Maneuvers|Skill_Ranks_Combat_Maneuvers',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Combat_Maneuvers',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Multi Opponent Combat', 'Enhancive Skill', 'Increases skill bonus/ranks in Multi Opponent Combat',  'Skill_Bonus_Multi_Opponent_Combat|Skill_Ranks_Multi_Opponent_Combat',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Multi_Opponent_Combat',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Physical Fitness', 'Enhancive Skill', 'Increases skill bonus/ranks in Physical Fitness',  'Skill_Bonus_Physical_Fitness|Skill_Ranks_Physical_Fitness',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Physical_Fitness',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Dodging', 'Enhancive Skill', 'Increases skill bonus/ranks in Dodging',  'Skill_Bonus_Dodging|Skill_Ranks_Dodging',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Dodging',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Arcane Symbols', 'Enhancive Skill', 'Increases skill bonus/ranks in Arcane Symbols',  'Skill_Bonus_Arcane_Symbols|Skill_Ranks_Arcane_Symbols',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Arcane_Symbols',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Magic Item Use', 'Enhancive Skill', 'Increases skill bonus/ranks in Magic Item Use',  'Skill_Bonus_Magic_Item_Use|Skill_Ranks_Magic_Item_Use',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Magic_Item_Use',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spell Aiming', 'Enhancive Skill', 'Increases skill bonus/ranks in Spell Aiming',  'Skill_Bonus_Spell_Aiming|Skill_Ranks_Spell_Aiming',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Spell_Aiming',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Harness Power', 'Enhancive Skill', 'Increases skill bonus/ranks in Harness Power',  'Skill_Bonus_Harness_Power|Skill_Ranks_Harness_Power',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Harness_Power',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Mana Control', 'Enhancive Skill', 'Increases skill bonus/ranks in Elemental Mana Control',  'Skill_Bonus_Elemental_Mana_Control|Skill_Ranks_Elemental_Mana_Control',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Elemental_Mana_Control',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental Mana Control', 'Enhancive Skill', 'Increases skill bonus/ranks in Mental Mana Control',  'Skill_Bonus_Mental_Mana_Control|Skill_Ranks_Mental_Mana_Control',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Mental_Mana_Control',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spiritual Mana Control', 'Enhancive Skill', 'Increases skill bonus/ranks in Spiritual Mana Control',  'Skill_Bonus_Spiritual_Mana_Control|Skill_Ranks_Spiritual_Mana_Control',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Spiritual_Mana_Control',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Lore, Air', 'Enhancive Skill', 'Increases skill bonus/ranks in Elemental Lore, Air',  'Skill_Bonus_Elemental_Lore_Air|Skill_Ranks_Elemental_Lore_Air',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Elemental_Lore_Air',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Lore, Earth', 'Enhancive Skill', 'Increases skill bonus/ranks in Elemental Lore, Earth',  'Skill_Bonus_Elemental_Lore_Earth|Skill_Ranks_Elemental_Lore_Earth',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Elemental_Lore_Earth',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Lore, Fire', 'Enhancive Skill', 'Increases skill bonus/ranks in Elemental Lore, Fire',  'Skill_Bonus_Elemental_Lore_Fire|Skill_Ranks_Elemental_Lore_Fire',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Elemental_Lore_Fire',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Lore, Water', 'Enhancive Skill', 'Increases skill bonus/ranks in Elemental Lore, Water',  'Skill_Bonus_Elemental_Lore_Water|Skill_Ranks_Elemental_Lore_Water',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Elemental_Lore_Water',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spiritual Lore, Blessings', 'Enhancive Skill', 'Increases skill bonus/ranks in Spiritual Lore, Blessings',  'Skill_Bonus_Spiritual_Lore_Blessings|Skill_Ranks_Spiritual_Lore_Blessings',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Spiritual_Lore_Blessings',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spiritual Lore, Religion', 'Enhancive Skill', 'Increases skill bonus/ranks in Spiritual Lore, Religion',  'Skill_Bonus_Spiritual_Lore_Religion|Skill_Ranks_Spiritual_Lore_Religion',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Spiritual_Lore_Religion',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spiritual Lore, Summoning', 'Enhancive Skill', 'Increases skill bonus/ranks in Spiritual Lore, Summoning',  'Skill_Bonus_Spiritual_Lore_Summoning|Skill_Ranks_Spiritual_Lore_Summoning',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Spiritual_Lore_Summoning',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sorcerous Lore, Demonology', 'Enhancive Skill', 'Increases skill bonus/ranks in Sorcerous Lore, Demonology',  'Skill_Bonus_Sorcerous_Lore_Demonology|Skill_Ranks_Sorcerous_Lore_Demonology',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Sorcerous_Lore_Demonology',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sorcerous Lore, Necromancy', 'Enhancive Skill', 'Increases skill bonus/ranks in Sorcerous Lore, Necromancy',  'Skill_Bonus_Sorcerous_Lore_Necromancy|Skill_Ranks_Sorcerous_Lore_Necromancy',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Sorcerous_Lore_Necromancy',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental Lore, Divination', 'Enhancive Skill', 'Increases skill bonus/ranks in Mental Lore, Divination',  'Skill_Bonus_Mental_Lore_Divination|Skill_Ranks_Mental_Lore_Divination',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Mental_Lore_Divination',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental Lore, Manipulation', 'Enhancive Skill', 'Increases skill bonus/ranks in Mental Lore, Manipulation',  'Skill_Bonus_Mental_Lore_Manipulation|Skill_Ranks_Mental_Lore_Manipulation',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Mental_Lore_Manipulation',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental Lore, Telepathy', 'Enhancive Skill', 'Increases skill bonus/ranks in Mental Lore, Telepathy',  'Skill_Bonus_Mental_Lore_Telepathy|Skill_Ranks_Mental_Lore_Telepathy',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Mental_Lore_Telepathy',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental Lore, Transference', 'Enhancive Skill', 'Increases skill bonus/ranks in Mental Lore, Transference',  'Skill_Bonus_Mental_Lore_Transference|Skill_Ranks_Mental_Lore_Transference',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Mental_Lore_Transference',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental Lore, Transformation', 'Enhancive Skill', 'Increases skill bonus/ranks in Mental Lore, Transformation',  'Skill_Bonus_Mental_Lore_Transformation|Skill_Ranks_Mental_Lore_Transformation',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Mental_Lore_Transformation',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Survival', 'Enhancive Skill', 'Increases skill bonus/ranks in Survival',  'Skill_Bonus_Survival|Skill_Ranks_Survival',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Survival',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Disarm Traps', 'Enhancive Skill', 'Increases skill bonus/ranks in Disarm Traps',  'Skill_Bonus_Disarm Traps|Skill_Ranks_Disarm_Traps',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Disarm_Traps',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Picking Locks', 'Enhancive Skill', 'Increases skill bonus/ranks in Picking Locks',  'Skill_Bonus_Picking_Locks|Skill_Ranks_Picking_Locks',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Picking_Locks',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Stalking and Hiding', 'Enhancive Skill', 'Increases skill bonus/ranks in Stalking and Hiding',  'Skill_Bonus_Stalking_and_Hiding|Skill_Ranks_Stalking_and_Hiding',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Stalking_and_Hiding',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Perception', 'Enhancive Skill', 'Increases skill bonus/ranks in Perception',  'Skill_Bonus_Perception|Skill_Ranks_Perception',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Perception',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Climbing', 'Enhancive Skill', 'Increases skill bonus/ranks in Climbing',  'Skill_Bonus_Climbing|Skill_Ranks_Climbing',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Climbing',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Swimming', 'Enhancive Skill', 'Increases skill bonus/ranks in Swimming',  'Skill_Bonus_Swimming|Skill_Ranks_Swimming',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Swimming',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('First Aid', 'Enhancive Skill', 'Increases skill bonus/ranks in First Aid',  'Skill_Bonus_First_Aid|Skill_Ranks_First_Aid',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_First_Aid',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Trading', 'Enhancive Skill', 'Increases skill bonus/ranks in Trading',  'Skill_Bonus_Trading|Skill_Ranks_Trading',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Trading',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Pickpocketing', 'Enhancive Skill', 'Increases skill bonus/ranks in Pickpocketing',  'Skill_Bonus_Pickpocketing|Skill_Ranks_Pickpocketing',  'Skill ranks:0-50|Skill bonus:0-50',  'Calculate_Enhancive_Pickpocketing',  'NONE' ) "

      # Enhancive effects that modify character statistics
      db.execute "INSERT INTO Effects VALUES('Strength Enhancive', 'Enhancive Statistic', 'Increases Strength statistic/bonus',  'Statistic_Strength|Statistic_Bonus_Strength',  'Statistic increase:0-40|Statistic bonus:0-20',  'Calculate_Enhancive_Strength',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Constitution Enhancive', 'Enhancive Statistic', 'Increases Constitution statistic/bonus',  'Statistic_Constitution|Statistic_Bonus_Constitution',  'Statistic increase:0-40|Statistic bonus:0-20',  'Calculate_Enhancive_Constitution',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Dexterity Enhancive', 'Enhancive Statistic', 'Increases Dexterity statistic/bonus',  'Statistic_Dexterity|Statistic_Bonus_Dexterity',  'Statistic increase:0-40|Statistic bonus:0-20',  'Calculate_Enhancive_Dexterity',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Agility Enhancive', 'Enhancive Statistic', 'Increases Agility statistic/bonus',  'Statistic_Agility|Statistic_Bonus_Agility',  'Statistic increase:0-40|Statistic bonus:0-20',  'Calculate_Enhancive_Agility',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Discipline Enhancive', 'Enhancive Statistic', 'Increases Discipline statistic/bonus',  'Statistic_Discipline|Statistic_Bonus_Discipline',  'Statistic increase:0-40|Statistic bonus:0-20',  'Calculate_Enhancive_Discipline',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Aura Enhancive', 'Enhancive Statistic', 'Increases Aura statistic/bonus',  'Statistic_Aura|Statistic_Bonus_Aura',  'Statistic increase:0-40|Statistic bonus:0-20',  'Calculate_Enhancive_Aura',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Logic Enhancive', 'Enhancive Statistic', 'Increases Logic statistic/bonus',  'Statistic_Logic|Statistic_Bonus_Logic',  'Statistic increase:0-40|Statistic bonus:0-20',  'Calculate_Enhancive_Logic',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Intuition Enhancive', 'Enhancive Statistic', 'Increases Intuition statistic/bonus',  'Statistic_Intuition|Statistic_Bonus_Intuition',  'Statistic increase:0-40|Statistic bonus:0-20',  'Calculate_Enhancive_Intuition',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Wisdom Enhancive', 'Enhancive Statistic', 'Increases Wisdom statistic/bonus',  'Statistic_Wisdom|Statistic_Bonus_Wisdom',  'Statistic increase:0-40|Statistic bonus:0-20',  'Calculate_Enhancive_Wisdom',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Influence Enhancive', 'Enhancive Statistic', 'Increases Influence statistic/bonus',  'Statistic_Influence|Statistic_Bonus_Influence',  'Statistic increase:0-40|Statistic bonus:0-20',  'Calculate_Enhancive_Influence',  'NONE' ) "

      # Generic Bonus effects
      db.execute "INSERT INTO Effects VALUES('All AS Bonus', 'Generic Bonus', '+1 to +100 all AS',  'AS_All|UAF',  'All AS bonus:1-100',  'Calculate_Generic_All_AS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Melee AS Bonus', 'Generic Bonus', '+1 to +100 melee AS',  'AS_Melee',  'Melee AS bonus:1-100',  'Calculate_Generic_Melee_AS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Ranged AS Bonus', 'Generic Bonus', '+1 to +100 ranged AS',  'AS_Ranged',  'Ranged AS bonus:1-100',  'Calculate_Generic_Ranged_AS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Bolt AS Bonus', 'Generic Bonus', '+1 to +100 bolt AS',  'AS_Bolt',  'Bolt AS bonus:1-100',  'Calculate_Generic_Bolt_AS',  'NONE' ) "

      db.execute "INSERT INTO Effects VALUES('UAF Bonus', 'Generic Bonus', '+1 to +100 UAF',  'UAF',  'UAF bonus:1-100',  'Calculate_Generic_UAF',  'NONE' ) "

      db.execute "INSERT INTO Effects VALUES('All DS Bonus', 'Generic Bonus', '+1 to +100 all DS',  'DS_All',  'All DS bonus:1-100',  'Calculate_Generic_All_DS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Melee DS Bonus', 'Generic Bonus', '+1 to +100 melee DS',  'DS_Melee',  'Melee DS bonus:1-100',  'Calculate_Generic_Melee_DS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Ranged DS Bonus', 'Generic Bonus', '+1 to +100 ranged DS',  'DS_Ranged',  'Ranged DS bonus:1-100',  'Calculate_Generic_Ranged_DS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Bolt DS Bonus', 'Generic Bonus', '+1 to +100 bolt DS',  'DS_Bolt',  'Bolt DS bonus:1-100',  'Calculate_Generic_Bolt_DS',  'NONE' ) "

      db.execute "INSERT INTO Effects VALUES('All CS Bonus', 'Generic Bonus', '+1 to +100 all CS',  'CS_All',  'All CS bonus:1-100',  'Calculate_Generic_All_CS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental CS Bonus', 'Generic Bonus', '+1 to +100 elemental CS',  'CS_Elemental',  'Elemental CS bonus:1-100',  'Calculate_Generic_Elemental_CS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental CS Bonus', 'Generic Bonus', '+1 to +100 mental CS',  'CS_Mental',  'Mental CS bonus:1-100',  'Calculate_Generic_Mental_CS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spiritual CS Bonus', 'Generic Bonus', '+1 to +100 spiritual CS',  'CS_Spiritual',  'Spiritual CS bonus:1-100',  'Calculate_Generic_Spiritual_CS',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sorcerer CS Bonus', 'Generic Bonus', '+1 to +100 sorcerer CS',  'CS_Sorcerer',  'Sorcerer CS bonus:1-100',  'Calculate_Generic_Sorcerer_CS',  'NONE' ) "

      db.execute "INSERT INTO Effects VALUES('All TD Bonus', 'Generic Bonus', '+1 to +100 all TD',  'TD_All',  'All TD bonus:1-100',  'Calculate_Generic_All_TD',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental TD Bonus', 'Generic Bonus', '+1 to +100 elemental TD',  'TD_Elemental',  'Elemental TD bonus:1-100',  'Calculate_Generic_Elemental_TD',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental TD Bonus', 'Generic Bonus', '+1 to +100 mental TD',  'TD_Mental',  'Mental TD bonus:1-100',  'Calculate_Generic_Mental_TD',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spiritual TD Bonus', 'Generic Bonus', '+1 to +100 spiritual TD',  'TD_Spiritual',  'Spiritual TD bonus:1-100',  'Calculate_Generic_Spiritual_TD',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Sorcerer TD Bonus', 'Generic Bonus', '+1 to +100 sorcerer TD',  'TD_Sorcerer',  'Sorcerer TD bonus:1-100',  'Calculate_Generic_Sorcerer_TD',  'NONE' ) "

      # Status effects
      db.execute "INSERT INTO Effects VALUES('Kneeling', 'Status', '-50 AS and DS\n+30 ranged AS if using a crossbow\n+5% stamina recovery',  'AS_Melee|AS_Ranged|AS_Bolt|DS_All|Resource_Recovery_Stamina_Normal',  'NONE',  'Calculate_Kneeling',  'Main Weapon' ) "
      db.execute "INSERT INTO Effects VALUES('Lying Down', 'Status', '-50 AS and DS\n+30 ranged AS if using a crossbow\n+5% stamina recovery',  'AS_Melee|AS_Ranged|AS_Bolt|DS_All|Resource_Recovery_Stamina_Normal',  'NONE',  'Calculate_Lying_Down',  'Main Weapon' ) "
      db.execute "INSERT INTO Effects VALUES('Overexerted', 'Status', '-10 AS/UAF.\nAlso known as Popped Muscles',  'AS_All|UAF',  'NONE',  'Calculate_Overexerted',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Rooted', 'Status', '-50 to melee AS, -25 to ranged AS, -25 to all DS\n',  'AS_Melee|AS_Ranged|DS_All',  'NONE',  'Calculate_Rooted',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Stunned', 'Status', '-20 to all DS',  'DS_All|Parry_Chance|Evade_Chance|Block_Chance',  'NONE',  'Calculate_Stunned',  'NONE' ) "

      # Flare effects. These are usually short term boosts that are triggered by another effect
      db.execute "INSERT INTO Effects VALUES('Acuity AS Flare', 'Flare', '+5 bonus to bolt AS on next spell cast per tier',  'AS_Bolt',  'Tier:1-10',  'Calculate_Acuity_AS_Flare',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Acuity CS Flare', 'Flare', '+3 bonus to all CS on next cast per tier',  'CS_All',  'Tier:1-10',  'Calculate_Acuity_CS_Flare',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Ensorcell AS Flare', 'Flare', '+5/+10/+15/+20/+25 bonus to AS on next melee, ranged, UAF attack',  'AS_All|UAF',  'Tier:1-5',  'Calculate_Ensorcell_AS_Flare',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Ensorcell CS Flare', 'Flare', '+5/+10/+15/+20/+25 bonus to all CS',  'CS_All',  'Tier:1-5',  'Calculate_Ensorcell_CS_Flare',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit Warding II (107) Flare', 'Flare', '+25 bonus to all TD',  'TD_All',  'NONE',  'Calculate_107_Flare',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Benediction (307) Flare', 'Flare', '+15 bonus to all AS and UAF',  'AS_All|UAF',  'NONE',  'Calculate_307_Flare',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES(\"Thurfel\'s Ward (503) Flare\", 'Flare', '+20 all DS',  'DS_All',  'NONE',  'Calculate_503_Flare',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Bias (508) Flare', 'Flare', '+20 Elemental TD, +10 Spiritual TD',  'TD_Elemental|TD_Mental|TD_Spiritual|TD_Sorcerer',  'NONE',  'Calculate_508_Flare',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Focus (513) Flare', 'Flare', '+1 Bolt AS per seed 4 summation of Elemental Lore,\nFire ranks on consecutive bolt attacks',  'AS_Bolt',  'Elemental Lore, Fire ranks:202',  'Calculate_513_Flare',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Curse (715) Star', 'Flare', '+10 bolt AS\n+1 bolt AS per 3 Spell Research, Sorcerer ranks above 15, capped character level',  'AS_Bolt',  'Spell Research, Sorcerer ranks:303',  'Calculate_715_Flare',  'NONE' ) "

      # Special Ability effects
      db.execute "INSERT INTO Effects VALUES('Casting Strength (Arcane Symbols)', 'Special Ability', 'Increases CS for non-native spell circles when casting spell from a scroll.\nDoes not stack with Elemental Targeting (425)\nCS increase is by Arcane Symbol rank:\n0.75 per rank up to character level.\n0.5 per rank up to 2x character level.\n0.33 per rank above 2x character level.',  'CS_Special',  'NONE',  'Calculate_CS_Boost_Arcane_Symbols',  'CS Boost AS' ) "
      db.execute "INSERT INTO Effects VALUES('Casting Strength (Magic Item Use)', 'Special Ability', 'Increases CS for non-native spell circles when casting spell from a scroll.\nDoes not stack with Elemental Targeting (425)\nCS increase is by Magic Item Use rank:\n0.75 per rank up to character level.\n0.5 per rank up to 2x character level.\n0.33 per rank above 2x character level.',  'CS_Special',  'NONE',  'Calculate_CS_Boost_Magic_Item_Use',  'CS Boost MIU' ) "
      db.execute "INSERT INTO Effects VALUES('Meditate (Mana)', 'Special Ability', 'Mana recovery increased by (Discipline bonus + Wisdom bonus) / 2',  'Resource_Recovery_Mana_Normal',  'NONE',  'Calculate_Meditate_Mana',  'Discipline Bonus|Wisdom Bonus' ) "
      db.execute "INSERT INTO Effects VALUES('Stamina Burst', 'Special Ability', '+15% stamina recovery',  'Resource_Recovery_Stamina',  'NONE',  'Calculate_Stamina_Burst',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Stamina Burst (Cooldown)', 'Special Ability', '-15% stamina recovery',  'Resource_Recovery_Stamina',  'NONE',  'Calculate_Stamina_Burst_Cooldown',  'NONE' ) "
      # Animal Companion Guard Bonus (will probably require a Misc panel update for affinity level) (need exact formula)

      # Items
      db.execute "INSERT INTO Effects VALUES('Defense Bonus Item', 'Item', '+5 all DS per tier (+5 to +50)',  'DS_All',  'Tier:1-10',  'Calculate_Item_Defense_Bonus',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Strength Crystal, Greater', 'Item', '+10 enhancive Strength bonus',  'Statistic_Bonus_Strength',  'NONE',  'Calculate_Item_Strength_Crystal_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Strength Crystal, Lesser', 'Item', '+5 enhancive Strength bonus',  'Statistic_Bonus_Strength',  'NONE',  'Calculate_Item_Strength_Crystal_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Constitution Crystal, Greater', 'Item', '+10 enhancive Constitution bonus',  'Statistic_Bonus_Constitution',  'NONE',  'Calculate_Item_Constitution_Crystal_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Constitution Crystal, Lesser', 'Item', '+5 enhancive Constitution bonus',  'Statistic_Bonus_Constitution',  'NONE',  'Calculate_Item_Constitution_Crystal_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Aura Crystal, Greater', 'Item', '+10 enhancive Aura bonus',  'Statistic_Bonus_Aura',  'NONE',  'Calculate_Item_Aura_Crystal_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Aura Crystal, Lesser', 'Item', '+5 enhancive Aura bonus',  'Statistic_Bonus_Aura',  'NONE',  'Calculate_Item_Aura_Crystal_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Logic Potion, Greater', 'Item', '+10 enhancive Logic bonus',  'Statistic_Bonus_Logic',  'NONE',  'Calculate_Item_Logic_Potion_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Logic Potion, Lesser', 'Item', '+5 enhancive Logic bonus',  'Statistic_Bonus_Logic',  'NONE',  'Calculate_Item_Logic_Potion_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Intuition Crystal, Greater', 'Item', '+10 enhancive Intuition bonus',  'Statistic_Bonus_Intuition',  'NONE',  'Calculate_Item_Intuition_Crystal_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Intuition Crystal, Lesser', 'Item', '+5 enhancive Intuition bonus',  'Statistic_Bonus_Intuition',  'NONE',  'Calculate_Item_Intuition_Crystal_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Wisdom Potion, Greater', 'Item', '+10 enhancive Wisdom bonus',  'Statistic_Bonus_Wisdom',  'NONE',  'Calculate_Item_Wisdom_Potion_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Wisdom Potion, Lesser', 'Item', '+5 enhancive Wisdom bonus',  'Statistic_Bonus_Wisdom',  'NONE',  'Calculate_Item_Wisdom_Potion_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mana Regen Potion, Minor', 'Item', '+3 mana regeneration',  'Resource_Recovery_Mana',  'NONE',  'Calculate_Item_Mana_Regeneration_Potion_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mana Regen Potion, Lesser', 'Item', '+8 mana regeneration',  'Resource_Recovery_Mana',  'NONE',  'Calculate_Item_Mana_Regeneration_Potion_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mana Regen Potion, Greater', 'Item', '+13 mana regeneration',  'Resource_Recovery_Mana',  'NONE',  'Calculate_Item_Mana_Regeneration_Potion_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit Regen Crystal, Minor', 'Item', '+1 spirit regeneration',  'Resource_Recovery_Spirit',  'NONE',  'Calculate_Item_Spirit_Regeneration_Crystal_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit Regen Crystal, Lesser', 'Item', '+2 spirit regeneration',  'Resource_Recovery_Spirit',  'NONE',  'Calculate_Item_Spirit_Regeneration_Crystal_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit Regen Crystal, Greater', 'Item', '+3 spirit regeneration',  'Resource_Recovery_Spirit',  'NONE',  'Calculate_Item_Spirit_Regeneration_Crystal_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Stamina Regen Crystal, Minor', 'Item', '+10 stamina regeneration',  'Resource_Recovery_Stamina',  'NONE',  'Calculate_Item_Stamina_Regeneration_Crystal_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Stamina Regen Crystal, Lesser', 'Item', '+20 stamina regeneration',  'Resource_Recovery_Stamina',  'NONE',  'Calculate_Item_Stamina_Regeneration_Crystal_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Stamina Regen Crystal, Greater', 'Item', '+30 stamina regeneration',  'Resource_Recovery_Stamina',  'NONE',  'Calculate_Item_Stamina_Regeneration_Crystal_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Health-well Potion, Minor', 'Item', '+10 maximum health',  'Resource_Maximum_Health',  'NONE',  'Calculate_Item_Health_Well_Potion_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Health-well Potion, Lesser', 'Item', '+25 maximum health',  'Resource_Maximum_Health',  'NONE',  'Calculate_Item_Health_Well_Potion_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Health-well Potion, Greater', 'Item', '+50 maximum health',  'Resource_Maximum_Health',  'NONE',  'Calculate_Item_Health_Well_Potion_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mana-well Potion, Minor', 'Item', '+10 maximum mana',  'Resource_Maximum_Mana',  'NONE',  'Calculate_Item_Mana_Well_Potion_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mana-well Potion, Lesser', 'Item', '+25 maximum mana',  'Resource_Maximum_Mana',  'NONE',  'Calculate_Item_Mana_Well_Potion_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mana-well Potion, Greater', 'Item', '+50 maximum mana',  'Resource_Maximum_Mana',  'NONE',  'Calculate_Item_Mana_Well_Potion_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit-well Potion, Minor', 'Item', '+1 maximum spirit',  'Resource_Maximum_Spirit',  'NONE',  'Calculate_Item_Spirit_Well_Potion_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit-well Potion, Lesser', 'Item', '+2 maximum spirit',  'Resource_Maximum_Spirit',  'NONE',  'Calculate_Item_Spirit_Well_Potion_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spirit-well Potion, Greater', 'Item', '+3 maximum spirit',  'Resource_Maximum_Spirit',  'NONE',  'Calculate_Item_Spirit_Well_Potion_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Focus Crystal, Minor', 'Item', '+10 elemental CS',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_Item_Elemental_Focus_Crystal_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Focus Crystal, Lesser', 'Item', '+15 elemental CS',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_Item_Elemental_Focus_Crystal_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Elemental Focus Crystal, Greater', 'Item', '+25 elemental CS',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_Item_Elemental_Focus_Crystal_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental Focus Crystal, Minor', 'Item', '+10 mental CS',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_Item_Mental_Focus_Crystal_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental Focus Crystal, Lesser', 'Item', '+15 mental CS',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_Item_Mental_Focus_Crystal_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Mental Focus Crystal, Greater', 'Item', '+25 mental CS',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_Item_Mental_Focus_Crystal_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spiritual Focus Crystal, Minor', 'Item', '+10 spiritual CS',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_Item_Spiritual_Focus_Crystal_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spiritual Focus Crystal, Lesser', 'Item', '+15 spiritual CS',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_Item_Spiritual_Focus_Crystal_Lesser',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Spiritual Focus Crystal, Greater', 'Item', '+25 spiritual CS',  'CS_Elemental|CS_Mental|CS_Spiritual|CS_Sorcerer',  'NONE',  'Calculate_Item_Spiritual_Focus_Crystal_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Repelling Oil, Minor', 'Item', '+10 DS vs undead',  'DS_All',  'NONE',  'Calculate_Item_Repelling_Oil_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Repelling Oil, Greater', 'Item', '+30 DS vs undead',  'DS_All',  'NONE',  'Calculate_Item_Repelling_Oil_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Exorcism Oil, Minor', 'Item', '+10 AS vs undead',  'AS_All',  'NONE',  'Calculate_Item_Exorcism_Oil_Minor',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Exorcism Oil, Greater', 'Item', '+30 AS vs undead',  'AS_All',  'NONE',  'Calculate_Item_Exorcism_Oil_Greater',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Encumbrance Potion', 'Item', ' Reduces encumbrance by 40 pounds',  'Encumbrance_Reduction_Absolute',  'NONE',  'Calculate_Item_Encumbrance_Potion',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Encumbrance Charm', 'Item', ' Reduces encumbrance by 100 pounds',  'Encumbrance_Reduction_Absolute',  'NONE',  'Calculate_Item_Encumbrance_Charm',  'NONE' ) "

      # Other effects that do not fit into any other category
      db.execute "INSERT INTO Effects VALUES('Bright', 'Room\nEffect', '-10 DS',  'DS_All',  'NONE',  'Calculate_Room_Bright',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Dark', 'Room\nEffect', '+20 DS',  'DS_All',  'NONE',  'Calculate_Room_Dark',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Foggy', 'Room\nEffect', '+30 DS',  'DS_All',  'NONE',  'Calculate_Room_Foggy',  'NONE' ) "
      db.execute "INSERT INTO Effects VALUES('Node', 'Room\nEffect', 'Base Mana Recovery is 25% instead of 15%',  'Resource_Recovery_Mana_Normal',  'NONE',  'Calculate_Room_Node',  'Node Room' ) "
      # Supernode

    end
  end

  # returns the number of rows in the races table.
  #   Used to see if we need to populate the table, and input for unit testing
  def getRowCount
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true
    db.get_first_value "SELECT Count() from Effects";
  end

  # truncates the races table
  #   Used primarily for unit testing
  def resetDatabaseTable
    db = SQLite3::Database.open DatabaseName
    db.execute "DELETE FROM Effects"
  end

  # Returns a hash based on the race passed in
  def getEffectsObjectFromDatabase(name)
    db = SQLite3::Database.open DatabaseName
    db.results_as_hash = true

    results = db.query "SELECT * from Effects where name=?", name
    result = results.next
  end

end
