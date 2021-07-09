require 'tk'
require 'tkextlib/tile'

require "./lib/classes/Race"
require "./lib/classes/Profession"
require "./lib/classes/Character"

def check_num(newval)
  return /^[ 0-9]*$/.match(newval) && newval.length <= 3
end

def it_has_been_written(val, stat, character, base)
  # Dereference the pointer with #{}
  myValue = "#{val}".to_i

  case stat
  when "str"
    character.getStats().setStr(myValue);
  when "con"
    character.getStats().setCon(myValue);
  when "dex"
    character.getStats().setDex(myValue);
  when "agi"
    character.getStats().setAgi(myValue);
  when "dis"
    character.getStats().setDis(myValue);
  when "aur"
    character.getStats().setAur(myValue);
  when "log"
    character.getStats().setLog(myValue);
  when "int"
    character.getStats().setInt(myValue);
  when "wis"
    character.getStats().setWis(myValue);
  when "inf"
    character.getStats().setInf(myValue);
  end

  # todo: Probably a hack.. should be a better way to do this
  Tk::Tile::Label.new(base) { text character.getStats().getStatTotal() }.grid(:column => 4, :row => 13, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getPTP() }.grid(:column => 4, :row => 14, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getMTP() }.grid(:column => 4, :row => 15, :sticky => 'e')
end

# left side
def StatsBasePanel(content, character)

  base = Tk::Tile::Frame.new(content) { width 200; height 200; padding "3 3 12 12" }.grid(:column => 1, :row => 3, :columnspan => 3, :sticky => 'e')

  Tk::Tile::Label.new(base) { text 'Statistic' }.grid(:column => 1, :row => 2)
  Tk::Tile::Label.new(base) { text 'Race Bonus' }.grid(:column => 2, :row => 2)
  Tk::Tile::Label.new(base) { text 'Growth Index' }.grid(:column => 3, :row => 2)
  Tk::Tile::Label.new(base) { text 'Base' }.grid(:column => 4, :row => 2)

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

  bonus = character.getRace()[:bonus]
  Tk::Tile::Label.new(base) { text bonus.getStr() }.grid(:column => 2, :row => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getCon() }.grid(:column => 2, :row => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getDex() }.grid(:column => 2, :row => 5, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getAgi() }.grid(:column => 2, :row => 6, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getDis() }.grid(:column => 2, :row => 7, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getAur() }.grid(:column => 2, :row => 8, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getLog() }.grid(:column => 2, :row => 9, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getInt() }.grid(:column => 2, :row => 10, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getWis() }.grid(:column => 2, :row => 11, :sticky => 'e')
  Tk::Tile::Label.new(base) { text bonus.getInf() }.grid(:column => 2, :row => 12, :sticky => 'e')

  growth = character.getProfession()[:growth]
  Tk::Tile::Label.new(base) { text growth.getStr() }.grid(:column => 3, :row => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getCon() }.grid(:column => 3, :row => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getDex() }.grid(:column => 3, :row => 5, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getAgi() }.grid(:column => 3, :row => 6, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getDis() }.grid(:column => 3, :row => 7, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getAur() }.grid(:column => 3, :row => 8, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getLog() }.grid(:column => 3, :row => 9, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getInt() }.grid(:column => 3, :row => 10, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getWis() }.grid(:column => 3, :row => 11, :sticky => 'e')
  Tk::Tile::Label.new(base) { text growth.getInf() }.grid(:column => 3, :row => 12, :sticky => 'e')

  stats = character.getStats()
  str = TkVariable.new(stats.getStr())
  str.trace("write", proc { |v| it_has_been_written(v, 'str', character, base) })
  con = TkVariable.new(stats.getCon())
  con.trace("write", proc { |v| it_has_been_written(v, 'con', character, base) })
  dex = TkVariable.new(stats.getDex())
  dex.trace("write", proc { |v| it_has_been_written(v, 'dex', character, base) })
  agi = TkVariable.new(stats.getAgi())
  agi.trace("write", proc { |v| it_has_been_written(v, 'agi', character, base) })
  dis = TkVariable.new(stats.getDis())
  dis.trace("write", proc { |v| it_has_been_written(v, 'dis', character, base) })
  aur = TkVariable.new(stats.getAur())
  aur.trace("write", proc { |v| it_has_been_written(v, 'aur', character, base) })
  log = TkVariable.new(stats.getLog())
  log.trace("write", proc { |v| it_has_been_written(v, 'log', character, base) })
  int = TkVariable.new(stats.getInt())
  int.trace("write", proc { |v| it_has_been_written(v, 'int', character, base) })
  wis = TkVariable.new(stats.getWis())
  wis.trace("write", proc { |v| it_has_been_written(v, 'wis', character, base) })
  inf = TkVariable.new(stats.getInf())
  inf.trace("write", proc { |v| it_has_been_written(v, 'inf', character, base) })

  myStr = Tk::Tile::Entry.new(base) { textvariable str; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 3, :sticky => 'e')
  myCon = Tk::Tile::Entry.new(base) { textvariable con; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 4, :sticky => 'e')
  myDex = Tk::Tile::Entry.new(base) { textvariable dex; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 5, :sticky => 'e')
  myAgi = Tk::Tile::Entry.new(base) { textvariable agi; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 6, :sticky => 'e')
  myDis = Tk::Tile::Entry.new(base) { textvariable dis; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 7, :sticky => 'e')
  myAur = Tk::Tile::Entry.new(base) { textvariable aur; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 8, :sticky => 'e')
  myLog = Tk::Tile::Entry.new(base) { textvariable log; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 9, :sticky => 'e')
  myInt = Tk::Tile::Entry.new(base) { textvariable int; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 10, :sticky => 'e')
  myWis = Tk::Tile::Entry.new(base) { textvariable wis; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 11, :sticky => 'e')
  myInf = Tk::Tile::Entry.new(base) { textvariable inf; width 4; validate 'key'; validatecommand [proc { |v| check_num(v) }, '%P'] }.grid(:column => 4, :row => 12, :sticky => 'e')

  Tk::Tile::Label.new(base) { text 'Statistics Total' }.grid(:column => 1, :row => 13, :columnspan => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text stats.getStatTotal() }.grid(:column => 4, :row => 13, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'PTP' }.grid(:column => 1, :row => 14, :columnspan => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getPTP() }.grid(:column => 4, :row => 14, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'MTP' }.grid(:column => 1, :row => 15, :columnspan => 3, :sticky => 'e')
  Tk::Tile::Label.new(base) { text character.getMTP() }.grid(:column => 4, :row => 15, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Exp. until next' }.grid(:column => 1, :row => 16, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Total Experience' }.grid(:column => 1, :row => 17, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) {}.grid(:column => 1, :row => 18, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Health' }.grid(:column => 1, :row => 19, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Mana' }.grid(:column => 1, :row => 20, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Stamina' }.grid(:column => 1, :row => 21, :columnspan => 4, :sticky => 'e')
  Tk::Tile::Label.new(base) { text 'Spirit' }.grid(:column => 1, :row => 22, :columnspan => 4, :sticky => 'e')

end

# top right
def StatsGrowthPanel(content)
  growth = Tk::Tile::Frame.new(content) { padding "3 3 12 12" }.grid(:column => 4, :row => 3, :columnspan => 4, :sticky => 'w')
  Tk::Tile::Label.new(growth) { text 'Stats Growth Panel' }.grid(:column => 1, :row => 1, :sticky => 'w')
end

# bottom right
def StatsTrainingPanel(content)
  training = Tk::Tile::Frame.new(content) { padding "3 3 12 12" }.grid(:column => 4, :row => 4, :columnspan => 4, :sticky => 'w')
  Tk::Tile::Label.new(training) { text 'Stats Training Panel' }.grid(:column => 1, :row => 1, :sticky => 'w')
end

def NavigationPanel(content)
  navigation = Tk::Tile::Frame.new(content) { padding "3 3 12 12" }.grid(:column => 1, :row => 1, :sticky => "ew")
  Tk::Tile::Label.new(navigation) { text 'Statistics' }.grid(:column => 1, :row => 1, :sticky => 'ew')
  Tk::Tile::Separator.new(navigation) { orient 'vertical' }
  Tk::Tile::Label.new(navigation) { text 'Misc' }.grid(:column => 2, :row => 1, :sticky => 'ew')
  Tk::Tile::Separator.new(navigation) { orient 'vertical' }
  Tk::Tile::Label.new(navigation) { text 'Skills' }.grid(:column => 3, :row => 1, :sticky => 'ew')
  Tk::Tile::Separator.new(navigation) { orient 'vertical' }
  Tk::Tile::Label.new(navigation) { text 'Maneuvers' }.grid(:column => 4, :row => 1, :sticky => 'ew')
  Tk::Tile::Separator.new(navigation) { orient 'vertical' }
  Tk::Tile::Label.new(navigation) { text 'Post Cap' }.grid(:column => 5, :row => 1, :sticky => 'ew')
  Tk::Tile::Separator.new(navigation) { orient 'vertical' }
  Tk::Tile::Label.new(navigation) { text 'Loadout' }.grid(:column => 6, :row => 1, :sticky => 'ew')
  Tk::Tile::Separator.new(navigation) { orient 'vertical' }
  Tk::Tile::Label.new(navigation) { text 'Progression' }.grid(:column => 7, :row => 1, :sticky => 'ew')
end

def change_profession(chosenProf, character, prof, race, content)
  character.setProfession(prof.getProfessionObjectFromDatabase(chosenProf.value))
  Tk.destroy
  StatsBasePanel(content, character)
end

def change_race(chosenRace, character, prof, race, content)
  character.setRace(race.getRaceObjectFromDatabase(chosenRace.value))
  StatsBasePanel(content, character)
end

def StatsChoosePanel(content, character, prof, race)
  chooser = Tk::Tile::Frame.new(content) { padding "3 3 12 12" }.grid(:column => 1, :row => 2, :sticky => "ew")
  chosenProf = TkVariable.new(character.getProfession()['name'])
  chosenRace = TkVariable.new(character.getRace()['name'])

  c = Tk::Tile::Combobox.new(chooser) { textvariable chosenProf }.grid(:column => 2, :row => 2)
  c.values = prof.getProfessionList()
  c.bind( "<ComboboxSelected>", proc { change_profession(chosenProf, character, prof, race, content) })

  r = Tk::Tile::Combobox.new(chooser) { textvariable chosenRace }.grid(:column => 3, :row => 2)
  r.values = race.getRaceList()
  r.bind( "<ComboboxSelected>", proc {change_race(chosenRace, character, prof, race, content)})
end

def StatsPanel(character, profession, race)
  root = TkRoot.new { title "GS4 Character Planner - #{character.getName()}" }

  content = Tk::Tile::Frame.new(content) { padding "3 3 12 12" }.grid(:sticky => 'nsew')

  TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1
  Tk::Tile::Style.configure('Danger.TFrame', "background" => "red")
  NavigationPanel(content)
  StatsChoosePanel(content, character, profession, race)
  StatsBasePanel(content, character)
  StatsGrowthPanel(content)
  StatsTrainingPanel(content)
  Tk.mainloop

end

race = Race.new
profession = Profession.new
character = Character.new

character.setName('Llyran')
character.setProfession(profession.getProfessionObjectFromDatabase('Warrior'))
character.setRace(race.getRaceObjectFromDatabase('Human'))


StatsPanel(character, profession, race)
puts character.inspect
