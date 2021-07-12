require 'tk'
require 'tkextlib/tile'

require "./lib/classes/Race"
require "./lib/classes/Profession"
require "./lib/classes/Character"

def check_num(new_val)
  /^[ 0-9]*$/.match(new_val) && new_val.length <= 3
end

def it_has_been_written(val, stat, character, base)
  # Dereference the pointer with #{}
  my_value = "#{val}".to_i

  case stat
  when "str"
    character.getStats.setStr(my_value);
  when "con"
    character.getStats.setCon(my_value);
  when "dex"
    character.getStats.setDex(my_value);
  when "agi"
    character.getStats.setAgi(my_value);
  when "dis"
    character.getStats.setDis(my_value);
  when "aur"
    character.getStats.setAur(my_value);
  when "log"
    character.getStats.setLog(my_value);
  when "int"
    character.getStats.setInt(my_value);
  when "wis"
    character.getStats.setWis(my_value);
  when "inf"
    character.getStats.setInf(my_value);
  end

  # todo: Probably a hack.. should be a better way to do this
  Tk::Tile::Label.new(base) { text character.getStats.getStatTotal }.grid(:column => 4, :row => 13, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getPTP }.grid(:column => 4, :row => 14, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getMTP }.grid(:column => 4, :row => 15, :sticky => 'e')
end

# left side
def stats_base_panel(content, character)
  base = Tk::Tile::Frame.new(content) { width 200; height 200; padding "3 3 12 12" }.grid(:column => 1, :row => 3, :columnspan => 3, :sticky => 'e')
  accumulated_experience = 0

  Tk::Tile::Label.new(base) { text 'Statistic' }.grid(:column => 1, :row => 2)
  Tk::Tile::Label.new(base) { text 'Race Bonus' }.grid(:column => 2, :row => 2)
  Tk::Tile::Label.new(base) { text 'Growth Index' }.grid(:column => 3, :row => 2)
  Tk::Tile::Label.new(base) { text 'Base' }.grid(:column => 4, :row => 2)

  # Tk::Tile::Label.new(base) { text 'Strength' + character.getProfession.isPrimeStat?('Strength') ? '(P)' : '' }.grid(:column => 1, :row => 3, :sticky => 'w')
  Tk::Tile::Label.new(base) { text 'Strength' }.grid(:column => 1, :row => 3, :sticky => 'w')
  Tk::Tile::Label.new(base) { text 'Constitution' }.grid(:column => 1, :row => 4, :sticky => 'w')
  Tk::Tile::Label.new(base) { text 'Dexterity' }.grid(:column => 1, :row => 5, :sticky => 'w')
  Tk::Tile::Label.new(base) { text 'Agility' }.grid(:column => 1, :row => 6, :sticky => 'w')
  Tk::Tile::Label.new(base) { text 'Discipline' }.grid(:column => 1, :row => 7, :sticky => 'w')
  Tk::Tile::Label.new(base) { text 'Aura' }.grid(:column => 1, :row => 8, :sticky => 'w')
  Tk::Tile::Label.new(base) { text 'Logic' }.grid(:column => 1, :row => 9, :sticky => 'w')
  Tk::Tile::Label.new(base) { text 'Intuition' }.grid(:column => 1, :row => 10, :sticky => 'w')
  Tk::Tile::Label.new(base) { text 'Wisdom' }.grid(:column => 1, :row => 11, :sticky => 'w')
  Tk::Tile::Label.new(base) { text 'Influence' }.grid(:column => 1, :row => 12, :sticky => 'w')

  Tk::Tile::Label.new(base) { text }

  bonus = character.getRace[:bonus]
  Tk::Tile::Label.new(base) { text bonus.getStr }.grid(:column => 2, :row => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getCon }.grid(:column => 2, :row => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getDex }.grid(:column => 2, :row => 5, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getAgi }.grid(:column => 2, :row => 6, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getDis }.grid(:column => 2, :row => 7, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getAur }.grid(:column => 2, :row => 8, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getLog }.grid(:column => 2, :row => 9, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getInt }.grid(:column => 2, :row => 10, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getWis }.grid(:column => 2, :row => 11, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getInf }.grid(:column => 2, :row => 12, :sticky => 'e')

  growth = character.getProfession[:growth]
  Tk::Tile::Label.new(base) { text growth.getStr }.grid(:column => 3, :row => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getCon }.grid(:column => 3, :row => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getDex }.grid(:column => 3, :row => 5, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getAgi }.grid(:column => 3, :row => 6, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getDis }.grid(:column => 3, :row => 7, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getAur }.grid(:column => 3, :row => 8, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getLog }.grid(:column => 3, :row => 9, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getInt }.grid(:column => 3, :row => 10, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getWis }.grid(:column => 3, :row => 11, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getInf }.grid(:column => 3, :row => 12, :sticky => 'e')

  stats = character.getStats
  str = TkVariable.new(stats.getStr)
  str.trace("write", proc { |v| it_has_been_written(v, 'str', character, base) })
  con = TkVariable.new(stats.getCon)
  con.trace("write", proc { |v| it_has_been_written(v, 'con', character, base) })
  dex = TkVariable.new(stats.getDex)
  dex.trace("write", proc { |v| it_has_been_written(v, 'dex', character, base) })
  agi = TkVariable.new(stats.getAgi)
  agi.trace("write", proc { |v| it_has_been_written(v, 'agi', character, base) })
  dis = TkVariable.new(stats.getDis)
  dis.trace("write", proc { |v| it_has_been_written(v, 'dis', character, base) })
  aur = TkVariable.new(stats.getAur)
  aur.trace("write", proc { |v| it_has_been_written(v, 'aur', character, base) })
  log = TkVariable.new(stats.getLog)
  log.trace("write", proc { |v| it_has_been_written(v, 'log', character, base) })
  int = TkVariable.new(stats.getInt)
  int.trace("write", proc { |v| it_has_been_written(v, 'int', character, base) })
  wis = TkVariable.new(stats.getWis)
  wis.trace("write", proc { |v| it_has_been_written(v, 'wis', character, base) })
  inf = TkVariable.new(stats.getInf)
  inf.trace("write", proc { |v| it_has_been_written(v, 'inf', character, base) })

  Tk::Tile::Entry.new(base) { textvariable str; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 3, :sticky => 'e')
  Tk::Tile::Entry.new(base) { textvariable con; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 4, :sticky => 'e')
  Tk::Tile::Entry.new(base) { textvariable dex; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 5, :sticky => 'e')
  Tk::Tile::Entry.new(base) { textvariable agi; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 6, :sticky => 'e')
  Tk::Tile::Entry.new(base) { textvariable dis; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 7, :sticky => 'e')
  Tk::Tile::Entry.new(base) { textvariable aur; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 8, :sticky => 'e')
  Tk::Tile::Entry.new(base) { textvariable log; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 9, :sticky => 'e')
  Tk::Tile::Entry.new(base) { textvariable int; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 10, :sticky => 'e')
  Tk::Tile::Entry.new(base) { textvariable wis; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 11, :sticky => 'e')
  Tk::Tile::Entry.new(base) { textvariable inf; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 12, :sticky => 'e')

  Tk::Tile::Label.new(base) { text 'Statistics Total' }.grid(:column => 1, :row => 13, :columnspan => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getStatTotal }.grid(:column => 4, :row => 13, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'PTP' }.grid(:column => 1, :row => 14, :columnspan => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getPTP }.grid(:column => 4, :row => 14, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'MTP' }.grid(:column => 1, :row => 15, :columnspan => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getMTP }.grid(:column => 4, :row => 15, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Exp. until next' }.grid(:column => 1, :row => 16, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Total Experience' }.grid(:column => 1, :row => 17, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) {}.grid(:column => 1, :row => 18, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Health' }.grid(:column => 1, :row => 19, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Mana' }.grid(:column => 1, :row => 20, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Stamina' }.grid(:column => 1, :row => 21, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Spirit' }.grid(:column => 1, :row => 22, :columnspan => 4, :sticky => 'e')

  # Now we start the growth (right) side of the panel
  # This is training 0, which is base stats with no growth
  Tk::Tile::Label.new(base) { text 0 }.grid(:column => 5, :row => 2, :sticky => 'nw')
  Tk::Tile::Label.new(base) { text stats.getStr }.grid(:column => 5, :row => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getCon }.grid(:column => 5, :row => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getDex }.grid(:column => 5, :row => 5, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getAgi }.grid(:column => 5, :row => 6, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getDis }.grid(:column => 5, :row => 7, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getAur }.grid(:column => 5, :row => 8, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getLog }.grid(:column => 5, :row => 9, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getInt }.grid(:column => 5, :row => 10, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getWis }.grid(:column => 5, :row => 11, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getInf }.grid(:column => 5, :row => 12, :sticky => 'e')

  Tk::Tile::Label.new(base) { text stats.getStatTotal }.grid(:column => 5, :row => 13, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getPTP }.grid(:column => 5, :row => 14, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getMTP }.grid(:column => 5, :row => 15, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getExperienceByLevel(0) }.grid(:column => 5, :row => 16, :sticky => 'e')
  Tk::Tile::Label.new(base) { text accumulated_experience }.grid(:column => 5, :row => 17, :sticky => 'e')

  Tk::Tile::Label.new(base) { text character.calcHealth(0) }.grid(:column => 5, :row => 19, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.calcMana(0) }.grid(:column => 5, :row => 20, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.calcStamina(0) }.grid(:column => 5, :row => 21, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.calcSpirit(0) }.grid(:column => 5, :row => 22, :sticky => 'e')

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

  # Loop to calculate growth for training levels 1..100
  for i in 1..10
    Tk::Tile::Label.new(base) { text i }.grid(:column => i+5, :row => 2, :sticky => 'nw')
    Tk::Tile::Label.new(base) { text growth_str[i] }.grid(:column => i+5, :row => 3, :sticky => 'e')
    Tk::Tile::Label.new(base) { text growth_con[i] }.grid(:column => i+5, :row => 4, :sticky => 'e')
    Tk::Tile::Label.new(base) { text growth_dex[i] }.grid(:column => i+5, :row => 5, :sticky => 'e')
    Tk::Tile::Label.new(base) { text growth_agi[i] }.grid(:column => i+5, :row => 6, :sticky => 'e')
    Tk::Tile::Label.new(base) { text growth_dis[i] }.grid(:column => i+5, :row => 7, :sticky => 'e')
    Tk::Tile::Label.new(base) { text growth_aur[i] }.grid(:column => i+5, :row => 8, :sticky => 'e')
    Tk::Tile::Label.new(base) { text growth_log[i] }.grid(:column => i+5, :row => 9, :sticky => 'e')
    Tk::Tile::Label.new(base) { text growth_int[i] }.grid(:column => i+5, :row => 10, :sticky => 'e')
    Tk::Tile::Label.new(base) { text growth_wis[i] }.grid(:column => i+5, :row => 11, :sticky => 'e')
    Tk::Tile::Label.new(base) { text growth_inf[i] }.grid(:column => i+5, :row => 12, :sticky => 'e')

    stat_total = growth_str[i] + growth_con[i] + growth_dex[i] + growth_agi[i] + growth_dis[i] +
      growth_aur[i] + growth_log[i] + growth_int[i] + growth_wis[i] + growth_inf[i]
    stat_ptp = character.getPtp_by_stats(growth_aur[i], growth_dis[i], growth_str[i], growth_con[i], growth_dex[i], growth_agi[i])
    stat_mtp = character.getMtp_by_stats(growth_aur[i], growth_dis[i], growth_log[i], growth_int[i], growth_wis[i], growth_inf[i])
    accumulated_experience += character.getExperienceByLevel(i)

    Tk::Tile::Label.new(base) { text stat_total }.grid(:column => i+5, :row => 13, :sticky => 'e')
    Tk::Tile::Label.new(base) { text stat_ptp }.grid(:column => i+5, :row => 14, :sticky => 'e')
    Tk::Tile::Label.new(base) { text stat_mtp }.grid(:column => i+5, :row => 15, :sticky => 'e')
    Tk::Tile::Label.new(base) { text character.getExperienceByLevel(i) }.grid(:column => i+5, :row => 16, :sticky => 'e')
    Tk::Tile::Label.new(base) { text accumulated_experience }.grid(:column => i+5, :row => 17, :sticky => 'e')

    Tk::Tile::Label.new(base) { text character.calcHealth(i) }.grid(:column => i+5, :row => 19, :sticky => 'e')
    Tk::Tile::Label.new(base) { text character.calcMana(i) }.grid(:column => i+5, :row => 20, :sticky => 'e')
    Tk::Tile::Label.new(base) { text character.calcStamina(i) }.grid(:column => i+5, :row => 21, :sticky => 'e')
    Tk::Tile::Label.new(base) { text character.calcSpirit(i) }.grid(:column => i+5, :row => 22, :sticky => 'e')

  end
end


def navigation_panel(content)
  navigation = Tk::Tile::Frame.new(content) { padding "3 3 12 12" }.grid(:column => 1, :row => 1, :sticky => "ew")
  Tk::Tile::Label.new(navigation) { text 'Statistics' }.grid(:column => 1, :row => 1, :sticky => 'ew')
  Tk::Tile::Label.new(navigation) { text 'Misc' }.grid(:column => 2, :row => 1, :sticky => 'ew')
  Tk::Tile::Label.new(navigation) { text 'Skills' }.grid(:column => 3, :row => 1, :sticky => 'ew')
  Tk::Tile::Label.new(navigation) { text 'Maneuvers' }.grid(:column => 4, :row => 1, :sticky => 'ew')
  Tk::Tile::Label.new(navigation) { text 'Post Cap' }.grid(:column => 5, :row => 1, :sticky => 'ew')
  Tk::Tile::Label.new(navigation) { text 'Loadout' }.grid(:column => 6, :row => 1, :sticky => 'ew')
  Tk::Tile::Label.new(navigation) { text 'Progression' }.grid(:column => 7, :row => 1, :sticky => 'ew')
end

def change_profession(chosen_prof, character, prof, content)
  character.setProfession(prof.getProfessionObjectFromDatabase(chosen_prof.value))
  Tk.destroy
  stats_base_panel(content, character)
end

def change_race(chosen_race, character, race, content)
  character.setRace(race.getRaceObjectFromDatabase(chosen_race.value))
  stats_base_panel(content, character)
end

def stats_choose_panel(content, character, prof, race)
  chooser = Tk::Tile::Frame.new(content) { padding "3 3 12 12" }.grid(:column => 1, :row => 2, :sticky => "ew")
  chosen_prof = TkVariable.new(character.getProfession['name'])
  chosen_race = TkVariable.new(character.getRace['name'])

  c = Tk::Tile::Combobox.new(chooser) { textvariable chosen_prof }.grid(:column => 2, :row => 2)
  c.values = prof.getProfessionList
  c.bind("<ComboboxSelected>", proc { change_profession(chosen_prof, character, prof, content) })

  r = Tk::Tile::Combobox.new(chooser) { textvariable chosen_race }.grid(:column => 3, :row => 2)
  r.values = race.getRaceList
  r.bind("<ComboboxSelected>", proc { change_race(chosen_race, character, race, content) })
end

def stats_panel(character, profession, race)
  root = TkRoot.new { title "GS4 Character Planner - #{character.getName}" }

  content = Tk::Tile::Frame.new(content) { padding "3 3 12 12" }.grid(:sticky => 'nsew')

  TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1
  Tk::Tile::Style.configure('Danger.TFrame', "background" => "red")
  navigation_panel(content)
  stats_choose_panel(content, character, profession, race)
  stats_base_panel(content, character)
  Tk.mainloop

end

race = Race.new
profession = Profession.new
character = Character.new

character.setName('Llyran')
character.setProfession(profession.getProfessionObjectFromDatabase('Warrior'))
character.setRace(race.getRaceObjectFromDatabase('Human'))

stats_panel(character, profession, race)
puts character.inspect
