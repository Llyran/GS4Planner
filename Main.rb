require 'tk'
require 'tkextlib/tile'

require "./lib/classes/Race"
require "./lib/classes/Profession"
require "./lib/classes/Character"

def check_num(new_val)
  /^[ 0-9]*$/.match(new_val) && new_val.length <= 3
end

def it_has_been_written(val, stat, character, content)
  my_value = val.value.to_i
  if my_value <= 20 || my_value > 100
    return
  end

  stats = character.getStats
  stat_names = stats.getStatNames

  character.getStats.setStat(stat, my_value)

  create_detail_line(content, stat, stat_names[stat.to_sym], character)
  create_footer_lines(content, character)

  my_total = character.getStats.getStatTotal
  my_ptp = character.getPTP
  my_mtp = character.getMTP

  # todo: Probably a hack.. should be a better way to do this
  Tk::Tile::Label.new(content) { text my_total }.grid(:column => 4, :row => 13, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text my_ptp }.grid(:column => 4, :row => 14, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text my_mtp }.grid(:column => 4, :row => 15, :sticky => 'e')['style'] = 'Column.TLabel'
end

def create_label(label, character)
  my_label = label
  my_label += character.isPrimeStat?(label) ? '  (P)' : ''
  my_label += character.isManaStat?(label) ? '  (M)' : ''
  return my_label
end

def create_header_line(container)
  Tk::Tile::Label.new(container) { text 'Statistic' }.grid(:column => 1, :row => 2)['style'] = 'ColumnHead.TLabel'
  Tk::Tile::Label.new(container) { text 'Race Bonus' }.grid(:column => 2, :row => 2)['style'] = 'ColumnHead.TLabel'
  Tk::Tile::Label.new(container) { text 'Growth Index' }.grid(:column => 3, :row => 2)['style'] = 'ColumnHead.TLabel'
  Tk::Tile::Label.new(container) { text 'Base' }.grid(:column => 4, :row => 2)['style'] = 'ColumnHead.TLabel'

  Tk::Tile::Label.new(container) { text 0 }.grid(:column => 5, :row => 2, :sticky => 'nw')['style'] = 'ColumnHead.TLabel'
  (1..10).each { |i| Tk::Tile::Label.new(container) { text i }.grid(:column => i + 5, :row => 2, :sticky => 'nw')['style'] = 'ColumnHead.TLabel' }
end

def create_detail_line(content, my_stat, my_stat_name, character)
  rows = {str: 3 ,con: 4, dex: 5, agi: 6, dis: 7, aur: 8, log: 9, int: 10, wis: 11, inf: 12}

  bonus = character.getRace[:bonus]
  stats = character.getStats

  row = rows[my_stat.to_sym]

  my_stats = stats.getStat(my_stat)
  my_bonus = bonus.getStat(my_stat)
  my_growth = character.getGrowthIndex(my_stat)

  Tk::Tile::Label.new(content) { text create_label(my_stat_name, character) }.grid(:column => 1, :row => row, :sticky => 'w')['style'] = 'ColumnHead.TLabel'
  Tk::Tile::Label.new(content) { text my_bonus }.grid(:column => 2, :row => row, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text my_growth }.grid(:column => 3, :row => row, :sticky => 'e')['style'] = 'Column.TLabel'

  # todo Because of variable bindings we might not be able to do this here.. Research please
  # Tk::Tile::Entry.new(content) { textvariable myStat; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => row, :sticky => 'e')

  Tk::Tile::Label.new(content) { text my_stats }.grid(:column => 5, :row => row, :sticky => 'e')['style'] = 'Column.TLabel'

  growth = character.calcGrowth(my_stat)
  (1..10).each { |i|
    Tk::Tile::Label.new(content) { text growth[i] }.grid(:column => i + 5, :row => row, :sticky => 'e')['style'] = 'Column.TLabel'
  }
end

# left side
def stats_base_panel(content, character)
  stats = character.getStats
  stat_names = stats.getStatNames

  base = Tk::Tile::Frame.new(content) { width 200; height 200; padding "3 3 12 12" }.grid(:column => 1, :row => 3, :columnspan => 3, :sticky => 'e')

  # This creates the header line .. titles and 0..100 column headers
  create_header_line(base)

  # This creates the detail lines for each of the stats
  stat_names.each do |stat, statName|
    create_detail_line(base, stat.to_s, statName, character)
  end

  str = TkVariable.new(stats.getStr)
  str.trace("write", proc { |v| it_has_been_written(v, 'str', character, base) })
  Tk::Tile::Entry.new(base) { textvariable str; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 3, :sticky => 'e')

  con = TkVariable.new(stats.getCon)
  con.trace("write", proc { |v| it_has_been_written(v, 'con', character, base) })
  Tk::Tile::Entry.new(base) { textvariable con; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 4, :sticky => 'e')

  dex = TkVariable.new(stats.getDex)
  dex.trace("write", proc { |v| it_has_been_written(v, 'dex', character, base) })
  Tk::Tile::Entry.new(base) { textvariable dex; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 5, :sticky => 'e')

  agi = TkVariable.new(stats.getAgi)
  agi.trace("write", proc { |v| it_has_been_written(v, 'agi', character, base) })
  Tk::Tile::Entry.new(base) { textvariable agi; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 6, :sticky => 'e')

  dis = TkVariable.new(stats.getDis)
  dis.trace("write", proc { |v| it_has_been_written(v, 'dis', character, base) })
  Tk::Tile::Entry.new(base) { textvariable dis; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 7, :sticky => 'e')

  aur = TkVariable.new(stats.getAur)
  aur.trace("write", proc { |v| it_has_been_written(v, 'aur', character, base) })
  Tk::Tile::Entry.new(base) { textvariable aur; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 8, :sticky => 'e')

  log = TkVariable.new(stats.getLog)
  log.trace("write", proc { |v| it_has_been_written(v, 'log', character, base) })
  Tk::Tile::Entry.new(base) { textvariable log; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 9, :sticky => 'e')

  int = TkVariable.new(stats.getInt)
  int.trace("write", proc { |v| it_has_been_written(v, 'int', character, base) })
  Tk::Tile::Entry.new(base) { textvariable int; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 10, :sticky => 'e')

  wis = TkVariable.new(stats.getWis)
  wis.trace("write", proc { |v| it_has_been_written(v, 'wis', character, base) })
  Tk::Tile::Entry.new(base) { textvariable wis; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 11, :sticky => 'e')

  inf = TkVariable.new(stats.getInf)
  inf.trace("write", proc { |v| it_has_been_written(v, 'inf', character, base) })
  Tk::Tile::Entry.new(base) { textvariable inf; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 12, :sticky => 'e')

  create_footer_lines(base, character)
end

def create_footer_lines(content, character)
  accumulated_experience = 0
  stats = character.getStats

  growth_str = character.calcGrowth('str')
  growth_con = character.calcGrowth('con')
  growth_dex = character.calcGrowth('dex')
  growth_agi = character.calcGrowth('agi')
  growth_dis = character.calcGrowth('dis')
  growth_aur = character.calcGrowth('aur')
  growth_log = character.calcGrowth('log')
  growth_int = character.calcGrowth('int')
  growth_wis = character.calcGrowth('wis')
  growth_inf = character.calcGrowth('inf')

  Tk::Tile::Label.new(content) { text 'Statistics Total' }.grid(:column => 1, :row => 13, :columnspan => 3, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text stats.getStatTotal }.grid(:column => 4, :row => 13, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text 'PTP' }.grid(:column => 1, :row => 14, :columnspan => 3, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text character.getPTP }.grid(:column => 4, :row => 14, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text 'MTP' }.grid(:column => 1, :row => 15, :columnspan => 3, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text character.getMTP }.grid(:column => 4, :row => 15, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text 'Exp. until next' }.grid(:column => 1, :row => 16, :columnspan => 4, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text 'Total Experience' }.grid(:column => 1, :row => 17, :columnspan => 4, :sticky => 'e')['style'] = 'Column.TLabel'

  Tk::Tile::Label.new(content) { text stats.getStatTotal }.grid(:column => 5, :row => 13, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text character.getPTP }.grid(:column => 5, :row => 14, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text character.getMTP }.grid(:column => 5, :row => 15, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text character.getExperienceByLevel(1) }.grid(:column => 5, :row => 16, :sticky => 'e')['style'] = 'Column.TLabel'

  (1..10).each { |i|
    stat_total = growth_str[i] + growth_con[i] + growth_dex[i] + growth_agi[i] + growth_dis[i] +
      growth_aur[i] + growth_log[i] + growth_int[i] + growth_wis[i] + growth_inf[i]

    stat_ptp = character.getPtp_by_stats(growth_aur[i], growth_dis[i], growth_str[i], growth_con[i], growth_dex[i], growth_agi[i])
    stat_mtp = character.getMtp_by_stats(growth_aur[i], growth_dis[i], growth_log[i], growth_int[i], growth_wis[i], growth_inf[i])

    Tk::Tile::Label.new(content) { text stat_total }.grid(:column => i + 5, :row => 13, :sticky => 'e')['style'] = 'Column.TLabel'
    Tk::Tile::Label.new(content) { text stat_ptp }.grid(:column => i + 5, :row => 14, :sticky => 'e')['style'] = 'Column.TLabel'
    Tk::Tile::Label.new(content) { text stat_mtp }.grid(:column => i + 5, :row => 15, :sticky => 'e')['style'] = 'Column.TLabel'
  }

  Tk::Tile::Label.new(content) {}.grid(:column => 1, :row => 18, :columnspan => 4, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text 'Health' }.grid(:column => 1, :row => 19, :columnspan => 4, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text 'Mana' }.grid(:column => 1, :row => 20, :columnspan => 4, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text 'Stamina' }.grid(:column => 1, :row => 21, :columnspan => 4, :sticky => 'e')['style'] = 'Column.TLabel'
  Tk::Tile::Label.new(content) { text 'Spirit' }.grid(:column => 1, :row => 22, :columnspan => 4, :sticky => 'e')['style'] = 'Column.TLabel'

  (1..10).each { |i|
    accumulated_experience += character.getExperienceByLevel(i)
    Tk::Tile::Label.new(content) { text character.getExperienceByLevel(i + 1) }.grid(:column => i + 5, :row => 16, :sticky => 'e')['style'] = 'Column.TLabel'
    Tk::Tile::Label.new(content) { text accumulated_experience }.grid(:column => i + 5, :row => 17, :sticky => 'e')['style'] = 'Column.TLabel'

    Tk::Tile::Label.new(content) { text character.calcHealth(i) }.grid(:column => i + 5, :row => 19, :sticky => 'e')['style'] = 'Column.TLabel'
    Tk::Tile::Label.new(content) { text character.calcMana(i) }.grid(:column => i + 5, :row => 20, :sticky => 'e')['style'] = 'Column.TLabel'
    Tk::Tile::Label.new(content) { text character.calcStamina(i) }.grid(:column => i + 5, :row => 21, :sticky => 'e')['style'] = 'Column.TLabel'
    Tk::Tile::Label.new(content) { text character.calcSpirit(i) }.grid(:column => i + 5, :row => 22, :sticky => 'e')['style'] = 'Column.TLabel'
  }
end

def change_profession(chosen_prof, character, prof, content)
  character.setProfession(prof.getProfessionObjectFromDatabase(chosen_prof.value))
  Tk.destroy
  stats_base_panel(content, character)
end

def change_race(chosen_race, character, race, content)
  character.setRace(race.getRaceObjectFromDatabase(chosen_race.value))
  Tk.destroy
  stats_base_panel(content, character)
end

def stats_choose_panel(content, character, prof, race)
  chooser = Tk::Tile::Frame.new(content) { padding "3 3 12 12" }.grid(:column => 1, :row => 2, :sticky => "ew")
  chosen_prof = TkVariable.new(character.getProfession['name'])
  chosen_race = TkVariable.new(character.getRace['name'])

  r = Tk::Tile::Combobox.new(chooser) { textvariable chosen_race }.grid(:column => 2, :row => 2)
  r.values = race.getRaceList
  r.bind("<ComboboxSelected>", proc { change_race(chosen_race, character, race, content) })

  c = Tk::Tile::Combobox.new(chooser) { textvariable chosen_prof }.grid(:column => 3, :row => 2)
  c.values = prof.getProfessionList
  c.bind("<ComboboxSelected>", proc { change_profession(chosen_prof, character, prof, content) })
end

def misc_panel(misc)
  Tk::Tile::Label.new(misc) {text "misc panel"}.grid(:column => 1, :row => 1, :sticky => 'we')['style'] = 'Emergency.TLabel'
end

def skills_panel(skills)
  Tk::Tile::Label.new(skills) {text "skills panel"}.grid(:column => 1, :row => 1, :sticky => 'we')['style'] = 'Emergency.TLabel'
end

def maneuvers_panel(maneuvers)
  Tk::Tile::Label.new(maneuvers) {text "maneuvers panel"}.grid(:column => 1, :row => 1, :sticky => 'we')['style'] = 'Emergency.TLabel'
end

def post_cap_panel(post_cap)
  Tk::Tile::Label.new(post_cap) {text "post_cap panel"}.grid(:column => 1, :row => 1, :sticky => 'we')['style'] = 'Emergency.TLabel'
end

def loadout_panel(loadout)
  Tk::Tile::Label.new(loadout) {text "loadout panel"}.grid(:column => 1, :row => 1, :sticky => 'we')['style'] = 'Emergency.TLabel'
end

def progression_panel(progression)
  Tk::Tile::Label.new(progression) {text "progression panel"}.grid(:column => 1, :row => 1, :sticky => 'we')['style'] = 'Emergency.TLabel'
end

def stats_panel(character, profession, race)
  set_styles
  root = TkRoot.new { title "GS4 Character Planner - #{character.getName}" }
  notebook = Tk::Tile::Notebook.new(root)do
    height 110
    place('height' => 700, 'width' => 1200, 'x' => 10, 'y' => 10)
   end

  statistics = Tk::Tile::Frame.new(notebook) { padding "3 3 12 12" }.grid(:sticky => 'nsew')
  misc = TkFrame.new(notebook)
  skills = TkFrame.new(notebook)
  maneuvers = TkFrame.new(notebook)
  post_cap = TkFrame.new(notebook)
  loadout = TkFrame.new(notebook)
  progression = TkFrame.new(notebook)

  TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1

  notebook.add statistics, :text => 'Statistics'
  notebook.add misc, :text => 'Misc'
  notebook.add skills, :text => 'Skills'
  notebook.add maneuvers, :text => 'Maneuvers'
  notebook.add post_cap, :text => 'Post Cap'
  notebook.add loadout, :text => 'Loadout'
  notebook.add progression, :text => 'Progression'

  stats_choose_panel(statistics, character, profession, race)
  stats_base_panel(statistics, character)

  misc_panel(misc)
  skills_panel(skills)
  maneuvers_panel(maneuvers)
  post_cap_panel(post_cap)
  loadout_panel(loadout)
  progression_panel(progression)

  Tk.mainloop

end

def set_styles
  Tk::Tile::Style.configure('Danger.TFrame', "background" => "red")
  Tk::Tile::Style.configure('Emergency.TLabel', { "font" => 'helvetica 24' })
  Tk::Tile::Style.configure('ColumnHead.TLabel', { "font" => 'helvetica 20', "bg" => 'red' })
  Tk::Tile::Style.configure('Column.TLabel', { "font" => 'helvetica 18', "background" => 'red' })
  Tk::Tile::Style.configure('Column.TEntry', { "font" => 'helvetica 18', "bg" => 'red' })
  Tk::Tile::Style.configure('TNotebook.Tab', {font: "helvetica 22"})
  Tk::Tile::Style.configure('TNotebook.Tab', {padding: "15 3 15 3"})
end

race = Race.new
profession = Profession.new
character = Character.new

character.setName('Llyran')
character.setProfession(profession.getProfessionObjectFromDatabase('Warrior'))
character.setRace(race.getRaceObjectFromDatabase('Human'))

stats_panel(character, profession, race)
puts character.inspect
