require "tk"
require "tkextlib/tile"

require "./lib/classes/Race"
require "./lib/classes/Profession"
require "./lib/classes/Character"

MAX_COLUMNS = 10

# This checks input values for stats.  Must be either a space, or begin with a numeral
# This also makes sure we have 3 or less digits, since valid range is 0..100
# @param [String] new_val  Should be an string of an int (0..999)
def check_num(new_val)
  /^[ 0-9]*$/.match(new_val) && new_val.length <= 3
end

# This tracks the actual change in one of the 10 stats.
# We use this hook to update all the stats as they're recalculated
# @param [String] val
# @param [String] stat
# @param [Object] character Common character object
# @param [Object] content
def it_has_been_written(val, stat, character, content)
  my_value = val.value.to_i

  # If we're outside of valid parameters, there's no need to update the display.
  return if my_value <= 20 || my_value > 100

  character.getStats.setStat(stat, my_value)

  create_detail_line(content, stat, character)
  create_footer_lines(content, character)

  # todo: Probably a hack.. should be a better way to do this
  Tk::Tile::Label.new(content) { text character.getStats.getStatTotal }.grid(:column => 4, :row => 13, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text character.getPTP }.grid(:column => 4, :row => 14, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text character.getMTP }.grid(:column => 4, :row => 15, :sticky => "e")["style"] = "Column.TLabel"
end

# Creates a stat label, with indicators for prime and mana stats
# @param [String] stat
# @param [Object] character Common character object
def create_label(stat, character)
  stats = character.getStats
  stat_names = stats.getStatNames
  label = stat_names[stat.to_sym]

  my_label = label
  my_label += character.isPrimeStat?(label) ? "  (P)" : ""
  my_label += character.isManaStat?(label) ? "  (M)" : ""
  return my_label
end

# Creates column header line
# @param [Object] container
def create_header_line(container)
  Tk::Tile::Label.new(container) { text "Statistic" }.grid(:column => 1, :row => 2)["style"] = "ColumnHead.TLabel"
  Tk::Tile::Label.new(container) { text "Race Bonus" }.grid(:column => 2, :row => 2)["style"] = "ColumnHead.TLabel"
  Tk::Tile::Label.new(container) { text "Growth Index" }.grid(:column => 3, :row => 2)["style"] = "ColumnHead.TLabel"
  Tk::Tile::Label.new(container) { text "Base" }.grid(:column => 4, :row => 2)["style"] = "ColumnHead.TLabel"

  Tk::Tile::Label.new(container) { text 0 }.grid(:column => 5, :row => 2, :sticky => "nw")["style"] = "ColumnHead.TLabel"
  (1..MAX_COLUMNS).each { |i| Tk::Tile::Label.new(container) { text i }.grid(:column => i + 5, :row => 2, :sticky => "nw")["style"] = "ColumnHead.TLabel" }
end

# Creates detail lines for each of the stats
#
# This is called in two ways.  First, it's called for each of the 10 stats, by a for loop.  Second it's called
# from the callback function when a stat changes, so it can update all level changes
# @param [Object] content
# @param [String] my_stat
# @param [Object] character Common character object
def create_detail_line(content, my_stat, character)
  rows = { str: 3, con: 4, dex: 5, agi: 6, dis: 7, aur: 8, log: 9, int: 10, wis: 11, inf: 12 }

  bonus = character.getRace[:bonus]
  stats = character.getStats

  row = rows[my_stat.to_sym]

  my_stats = stats.getStat(my_stat)
  my_bonus = bonus.getStat(my_stat)
  my_growth = character.getGrowthIndex(my_stat)

  Tk::Tile::Label.new(content) { text create_label(my_stat, character) }.grid(:column => 1, :row => row, :sticky => "w")["style"] = "ColumnHead.TLabel"
  Tk::Tile::Label.new(content) { text my_bonus }.grid(:column => 2, :row => row, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text my_growth }.grid(:column => 3, :row => row, :sticky => "e")["style"] = "Column.TLabel"

  # todo Because of variable bindings we might not be able to do this here.. Research please
  # Tk::Tile::Entry.new(content) { textvariable myStat; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => row, :sticky => "e")

  Tk::Tile::Label.new(content) { text my_stats }.grid(:column => 5, :row => row, :sticky => "e")["style"] = "Column.TLabel"

  growth = character.calcGrowth(my_stat)
  (1..MAX_COLUMNS).each { |i|
    Tk::Tile::Label.new(content) { text growth[i] }.grid(:column => i + 5, :row => row, :sticky => "e")["style"] = "Column.TLabel"
  }
end

# Creates the stats panel for the notebook
# @param [Object] content
# @param [Object] character Common character object
def stats_base_panel(content, character)
  stats = character.getStats
  stat_names = stats.getStatNames

  base = Tk::Tile::Frame.new(content) { width 200; height 200; padding "3 3 12 12" }.grid(:column => 1, :row => 3, :columnspan => 3, :sticky => "e")

  # This creates the header line .. titles and 0..100 column headers
  create_header_line(base)

  # This creates the detail lines for each of the stats
  stat_names.each_key do |stat|
    create_detail_line(base, stat.to_s, character)
  end

  str = TkVariable.new(stats.getStr)
  str.trace("write", proc { |v| it_has_been_written(v, "str", character, base) })
  Tk::Tile::Entry.new(base) { textvariable str; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => 3, :sticky => "e")

  con = TkVariable.new(stats.getCon)
  con.trace("write", proc { |v| it_has_been_written(v, "con", character, base) })
  Tk::Tile::Entry.new(base) { textvariable con; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => 4, :sticky => "e")

  dex = TkVariable.new(stats.getDex)
  dex.trace("write", proc { |v| it_has_been_written(v, "dex", character, base) })
  Tk::Tile::Entry.new(base) { textvariable dex; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => 5, :sticky => "e")

  agi = TkVariable.new(stats.getAgi)
  agi.trace("write", proc { |v| it_has_been_written(v, "agi", character, base) })
  Tk::Tile::Entry.new(base) { textvariable agi; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => 6, :sticky => "e")

  dis = TkVariable.new(stats.getDis)
  dis.trace("write", proc { |v| it_has_been_written(v, "dis", character, base) })
  Tk::Tile::Entry.new(base) { textvariable dis; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => 7, :sticky => "e")

  aur = TkVariable.new(stats.getAur)
  aur.trace("write", proc { |v| it_has_been_written(v, "aur", character, base) })
  Tk::Tile::Entry.new(base) { textvariable aur; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => 8, :sticky => "e")

  log = TkVariable.new(stats.getLog)
  log.trace("write", proc { |v| it_has_been_written(v, "log", character, base) })
  Tk::Tile::Entry.new(base) { textvariable log; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => 9, :sticky => "e")

  int = TkVariable.new(stats.getInt)
  int.trace("write", proc { |v| it_has_been_written(v, "int", character, base) })
  Tk::Tile::Entry.new(base) { textvariable int; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => 10, :sticky => "e")

  wis = TkVariable.new(stats.getWis)
  wis.trace("write", proc { |v| it_has_been_written(v, "wis", character, base) })
  Tk::Tile::Entry.new(base) { textvariable wis; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => 11, :sticky => "e")

  inf = TkVariable.new(stats.getInf)
  inf.trace("write", proc { |v| it_has_been_written(v, "inf", character, base) })
  Tk::Tile::Entry.new(base) { textvariable inf; width 4; validate "key"; validatecommand [proc { |v| check_num(v) }, "%P"] }.grid(:column => 4, :row => 12, :sticky => "e")

  create_footer_lines(base, character)
end

# creates the footer display and totals lines
# @param [Object] content
# @param [Object] character Common character object
def create_footer_lines(content, character)
  accumulated_experience = 0
  stats = character.getStats

  growth_str = character.calcGrowth("str")
  growth_con = character.calcGrowth("con")
  growth_dex = character.calcGrowth("dex")
  growth_agi = character.calcGrowth("agi")
  growth_dis = character.calcGrowth("dis")
  growth_aur = character.calcGrowth("aur")
  growth_log = character.calcGrowth("log")
  growth_int = character.calcGrowth("int")
  growth_wis = character.calcGrowth("wis")
  growth_inf = character.calcGrowth("inf")

  Tk::Tile::Label.new(content) { text "Statistics Total" }.grid(:column => 1, :row => 13, :columnspan => 3, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text "PTP" }.grid(:column => 1, :row => 14, :columnspan => 3, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text "MTP" }.grid(:column => 1, :row => 15, :columnspan => 3, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text "Exp. until next" }.grid(:column => 1, :row => 16, :columnspan => 4, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text "Total Experience" }.grid(:column => 1, :row => 17, :columnspan => 4, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text stats.getStatTotal }.grid(:column => 4, :row => 13, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text character.getPTP }.grid(:column => 4, :row => 14, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text character.getMTP }.grid(:column => 4, :row => 15, :sticky => "e")["style"] = "Column.TLabel"

  Tk::Tile::Label.new(content) { text stats.getStatTotal }.grid(:column => 5, :row => 13, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text character.getPTP }.grid(:column => 5, :row => 14, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text character.getMTP }.grid(:column => 5, :row => 15, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text character.getExperienceByLevel(1) }.grid(:column => 5, :row => 16, :sticky => "e")["style"] = "Column.TLabel"

  (1..MAX_COLUMNS).each { |i|
    stat_total = growth_str[i] + growth_con[i] + growth_dex[i] + growth_agi[i] + growth_dis[i] +
      growth_aur[i] + growth_log[i] + growth_int[i] + growth_wis[i] + growth_inf[i]

    stat_ptp = character.getPtp_by_stats(growth_aur[i], growth_dis[i], growth_str[i], growth_con[i], growth_dex[i], growth_agi[i])
    stat_mtp = character.getMtp_by_stats(growth_aur[i], growth_dis[i], growth_log[i], growth_int[i], growth_wis[i], growth_inf[i])

    Tk::Tile::Label.new(content) { text stat_total }.grid(:column => i + 5, :row => 13, :sticky => "e")["style"] = "Column.TLabel"
    Tk::Tile::Label.new(content) { text stat_ptp }.grid(:column => i + 5, :row => 14, :sticky => "e")["style"] = "Column.TLabel"
    Tk::Tile::Label.new(content) { text stat_mtp }.grid(:column => i + 5, :row => 15, :sticky => "e")["style"] = "Column.TLabel"
  }

  Tk::Tile::Label.new(content) {}.grid(:column => 1, :row => 18, :columnspan => 4, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text "Health" }.grid(:column => 1, :row => 19, :columnspan => 4, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text "Mana" }.grid(:column => 1, :row => 20, :columnspan => 4, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text "Stamina" }.grid(:column => 1, :row => 21, :columnspan => 4, :sticky => "e")["style"] = "Column.TLabel"
  Tk::Tile::Label.new(content) { text "Spirit" }.grid(:column => 1, :row => 22, :columnspan => 4, :sticky => "e")["style"] = "Column.TLabel"

  (1..MAX_COLUMNS).each { |i|
    accumulated_experience += character.getExperienceByLevel(i)
    Tk::Tile::Label.new(content) { text character.getExperienceByLevel(i + 1) }.grid(:column => i + 5, :row => 16, :sticky => "e")["style"] = "Column.TLabel"
    Tk::Tile::Label.new(content) { text accumulated_experience }.grid(:column => i + 5, :row => 17, :sticky => "e")["style"] = "Column.TLabel"

    Tk::Tile::Label.new(content) { text character.calcHealth(i) }.grid(:column => i + 5, :row => 19, :sticky => "e")["style"] = "Column.TLabel"
    Tk::Tile::Label.new(content) { text character.calcMana(i) }.grid(:column => i + 5, :row => 20, :sticky => "e")["style"] = "Column.TLabel"
    Tk::Tile::Label.new(content) { text character.calcStamina(i) }.grid(:column => i + 5, :row => 21, :sticky => "e")["style"] = "Column.TLabel"
    Tk::Tile::Label.new(content) { text character.calcSpirit(i) }.grid(:column => i + 5, :row => 22, :sticky => "e")["style"] = "Column.TLabel"
  }
end

# changes profession based on callback from choose profession select dialog
# @param [String] chosen_prof Selected profession from select dialog
# @param [Object] character
# @param [Object] prof
# @param [Object] content
def change_profession(chosen_prof, character, prof, content)
  character.setProfession(prof.getProfessionObjectFromDatabase(chosen_prof.value))
  Tk.destroy
  stats_base_panel(content, character)
end

# changes race based on callback from choose race select dialog
# @param [Object] chosen_race Selected race from select dialog
# @param [Object] character
# @param [Object] race
# @param [Object] content
def change_race(chosen_race, character, race, content)
  character.setRace(race.getRaceObjectFromDatabase(chosen_race.value))
  Tk.destroy
  stats_base_panel(content, character)
end

# Creates the two select box dropdowns
# @param [Object] content
# @param [Object] character
# @param [Object] prof
# @param [Object] race
def stats_choose_panel(content, character, prof, race)
  chooser = Tk::Tile::Frame.new(content) { padding "3 3 12 12" }.grid(:column => 1, :row => 2, :sticky => "ew")
  chosen_prof = TkVariable.new(character.getProfession["name"])
  chosen_race = TkVariable.new(character.getRace["name"])

  r = Tk::Tile::Combobox.new(chooser) { textvariable chosen_race }.grid(:column => 2, :row => 2)
  r.values = race.getRaceList
  r.bind("<ComboboxSelected>", proc { change_race(chosen_race, character, race, content) })

  c = Tk::Tile::Combobox.new(chooser) { textvariable chosen_prof }.grid(:column => 3, :row => 2)
  c.values = prof.getProfessionList
  c.bind("<ComboboxSelected>", proc { change_profession(chosen_prof, character, prof, content) })
end

# notebook tab for Statistics panel
# @param [Object] statistics
# @param [Object] character
# @param [Object] profession
# @param [Object] race
def stats_panel(statistics, character, profession, race)
  stats_choose_panel(statistics, character, profession, race)
  stats_base_panel(statistics, character)
end

# Skills panel stub.  This is where you choose your skill goals
def skills_panel(skills)
  Tk::Tile::Label.new(skills) { text "skills panel" }.grid(:column => 1, :row => 1, :sticky => "we")["style"] = "Emergency.TLabel"
end

# Combat Maneuvers panel.  Probablhy remain as a stub, until Simu rolls out their CM changes
def maneuvers_panel(maneuvers)
  Tk::Tile::Label.new(maneuvers) { text "maneuvers panel" }.grid(:column => 1, :row => 1, :sticky => "we")["style"] = "Emergency.TLabel"
end

# Post Cap stub.  Not a clue what this actually does, but we"ll figure it out when the time comes
def post_cap_panel(post_cap)
  Tk::Tile::Label.new(post_cap) { text "post_cap panel" }.grid(:column => 1, :row => 1, :sticky => "we")["style"] = "Emergency.TLabel"
end

# Misc panel stub.  Used to track guild skills and other random stuff that doesn"t fit anywhere else
def misc_panel(misc)
  Tk::Tile::Label.new(misc) { text "misc panel" }.grid(:column => 1, :row => 1, :sticky => "we")["style"] = "Emergency.TLabel"
end

# Loadout panel stub.  Will eventually let you choose weapons, armor, enhancives and such
def loadout_panel(loadout)
  Tk::Tile::Label.new(loadout) { text "loadout panel" }.grid(:column => 1, :row => 1, :sticky => "we")["style"] = "Emergency.TLabel"
end

# Progression panel stub
def progression_panel(progression)
  Tk::Tile::Label.new(progression) { text "progression panel" }.grid(:column => 1, :row => 1, :sticky => "we")["style"] = "Emergency.TLabel"
end

# creating the menu options
# @param [Object] root Root frame to tie a menu to
# @param [Object] character
def create_menu(root, character)
  # win = TkToplevel.new(root)
  menubar = TkMenu.new(root)
  root["menu"] = menubar

  file = TkMenu.new(menubar)
  edit = TkMenu.new(menubar)
  menubar.add :cascade, :menu => file, :label => "File"

  file.add :command, :label => "New Character", :command => proc { newCharacter }
  file.add :command, :label => "Load Character", :command => proc { selectCharacter(character, "Llyran", root) }
  file.add :command, :label => "Save Character", :command => proc { saveCharacter(character) }
  file.add :command, :label => "Save As..", :command => proc { saveCharacter(character) }
end

# Creates a new character with default race Human, and default profession Warrior
def newCharacter
  race = Race.new
  profession = Profession.new
  character = Character.new

  character.setProfession(profession.getProfessionObjectFromDatabase("Warrior"))
  character.setRace(race.getRaceObjectFromDatabase("Human"))

  return character
end

# This displays the select character dialog, showing which characters exist in the db table Characters.
#   Once a name is selected, control passes to loadCharacter()
# @param [Object] character
# @param [Object] name
# @param [Object] content
def selectCharacter(character, name, content)
  # get the list of names of characters stored in the db
  char_list = character.getCharactersFromDb

  # set up the bind variable, and populate it with the names
  names = TkVariable.new(char_list)

  # create the frame to hold the select box and place it
  listBox = Tk::Tile::Frame.new(content) { padding "5 5 12 0" }.grid :column => 0, :row => 0, :sticky => "nwes"
  TkGrid.columnconfigure content, 0, :weight => 1
  TkGrid.rowconfigure content, 0, :weight => 1

  # bind the variable to the listbox
  name_box = TkListbox.new(listBox) { listvariable names; height 3 }

  # Place the select box in the frame on the grid
  name_box.grid :column => 0, :row => 0, :rowspan => 3, :sticky => "nsew"
  TkGrid.columnconfigure name_box, 0, :weight => 1
  TkGrid.rowconfigure name_box, 5, :weight => 1

  # tie the event to the variable
  name_box.bind "<ListboxSelect>", proc { getCharacterFromDb(name_box.value[name_box.curselection[0]], listBox) }
  name_box.bind "Double-1", proc { getCharacterFromDb(name_box.value[name_box.curselection[0]], listBox) }
end

# Callback from the Load Character menu option.  This fires after the select box is displayed and a character name selected
#   This also destroys the selectCharacter dialog box once a character is chosen
# @param [Object] name
# @param [Object] listbox
def getCharacterFromDb(name, listbox)
  puts "made it to updateCharacter"

  puts name.inspect
  # puts sel.inspect
  # puts name[sel[0]]
  listbox.destroy
  loadCharacter(name)
end

# Should save a character, or alternatively save as a new character..
# @param [Object] character
def saveCharacter(character)
  puts "clicked the save character menu item"
end

# Retrieve a character from storage
# @param [String] name
def loadCharacter(name)
  race = Race.new
  profession = Profession.new
  character = Character.new

  character.setName(name)
  character.setProfession(profession.getProfessionObjectFromDatabase("Warrior"))
  character.setRace(race.getRaceObjectFromDatabase("Human"))

  return character
end

# One place to define all styles for the application.  Should make changes easier if they"re all in one place
def define_styles
  Tk::Tile::Style.configure("Danger.TFrame", { "background" => "#33FFFF" })
  Tk::Tile::Style.configure("Emergency.TLabel", { "font" => "helvetica 24" })
  Tk::Tile::Style.configure("ColumnHead.TLabel", { "font" => "helvetica 20" })
  Tk::Tile::Style.configure("Column.TLabel", { "font" => "helvetica 18" })
  Tk::Tile::Style.configure("Column.TEntry", { "font" => "helvetica 18" })
  Tk::Tile::Style.configure("TNotebook.Tab", { font: "helvetica 22" })
  Tk::Tile::Style.configure("TNotebook.Tab", { padding: "15 3 15 3" })
end

# This is set of frames.  It defines the menu, the noteboot tab navigation and styles
# @param [Object] character
# @param [Object] profession
# @param [Object] race
def main_container(character, profession, race)
  # Disable tear-off menu's.  Ancient tech
  TkOption.add "*tearOff", 0

  # Define styles
  define_styles

  # Create our display root, and add the menus
  root = TkRoot.new { title "GS4 Character Planner - #{character.getName}"; height 720; width 1220; background "#33FFFF" }
  create_menu(root, character)

  # Set up the notebook and define the tabs
  notebook = Tk::Tile::Notebook.new(root) { place("height" => 700, "width" => 1200, "x" => 10, "y" => 10) }

  statistics = Tk::Tile::Frame.new(notebook) { padding "3 3 12 12" }.grid(:sticky => "nsew")
  skills = Tk::Tile::Frame.new(notebook) { padding "3 3 12 12" }.grid(:sticky => "nsew")
  maneuvers = Tk::Tile::Frame.new(notebook) { padding "3 3 12 12" }.grid(:sticky => "nsew")
  post_cap = Tk::Tile::Frame.new(notebook) { padding "3 3 12 12" }.grid(:sticky => "nsew")
  misc = Tk::Tile::Frame.new(notebook) { padding "3 3 12 12" }.grid(:sticky => "nsew")
  loadout = Tk::Tile::Frame.new(notebook) { padding "3 3 12 12" }.grid(:sticky => "nsew")
  progression = Tk::Tile::Frame.new(notebook) { padding "3 3 12 12" }.grid(:sticky => "nsew")

  TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1

  notebook.add statistics, :text => "Statistics"
  notebook.add skills, :text => "Skills"
  notebook.add maneuvers, :text => "Maneuvers"
  notebook.add post_cap, :text => "Post Cap"
  notebook.add misc, :text => "Misc"
  notebook.add loadout, :text => "Loadout"
  notebook.add progression, :text => "Progression"

  stats_panel(statistics, character, profession, race)
  skills_panel(skills)
  maneuvers_panel(maneuvers)
  post_cap_panel(post_cap)
  misc_panel(misc)
  loadout_panel(loadout)
  progression_panel(progression)

  Tk.mainloop
end

race = Race.new
profession = Profession.new

character = newCharacter()
# character.setName("Llyran")
# character.setProfession(profession.getProfessionObjectFromDatabase("Warrior"))
# character.setRace(race.getRaceObjectFromDatabase("Human"))

main_container(character, profession, race)
puts character.inspect
