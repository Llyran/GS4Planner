require 'fox16'
include Fox

require "./lib/classes/Race"
require "./lib/classes/Profession"
require "./lib/classes/Character"

class GS4CharacterManager < FXMainWindow
  MAX_COLUMNS = 10

  def initialize(app)
    character = newCharacter
    super(app, "GS4 Character Generator", :width => 1560, :height => 900)
    add_tab_book(character)
  end

  def create
    super
    show()
  end

  # This checks input values for stats.  Must be either a space, or begin with a numeral
  # This also makes sure we have 3 or less digits, since valid range is 0..100
  # @param [String] new_val  Should be an string of an int (0..999)
  # def check_num(new_val)
  #   /^[ 0-9]*$/.match(new_val) && new_val.length <= 3
  # end

  def stat_data_changed(val, stat, character, form, row)
    my_value = val.to_i
    return if my_value <= 20 || my_value > 100

    character.getStats.setStat(stat, my_value)
    update_data_row(stat, row, character, form)
    update_total_rows(character, form)
  end

  def update_data_row(stat, row, character, form)
    growth = character.calcGrowth(stat)

    (0..MAX_COLUMNS).each_with_index do |value, index|
      cell = form.childAtRowCol(row, index * 2 + 3)
      cell.text = growth[index].to_s

      if (index > 0 && growth[index - 1] != growth[index])
        cell.backColor = "Green"
      else
        cell.backColor = Fox.FXRGB(212, 208, 200)
      end

    end
  end

  def update_total_rows(character, form)
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

    # this is the loop that populates the 0..100 arrays
    stat_total = []
    stat_ptp = []
    stat_mtp = []

    (0..MAX_COLUMNS).each { |i|
      stat_total[i] = growth_str[i] + growth_con[i] + growth_dex[i] + growth_agi[i] + growth_dis[i] +
        growth_aur[i] + growth_log[i] + growth_int[i] + growth_wis[i] + growth_inf[i]

      stat_ptp[i] = character.getPtp_by_stats(growth_aur[i], growth_dis[i], growth_str[i], growth_con[i], growth_dex[i], growth_agi[i])
      stat_mtp[i] = character.getMtp_by_stats(growth_aur[i], growth_dis[i], growth_log[i], growth_int[i], growth_wis[i], growth_inf[i])

      tot = form.childAtRowCol(11, i * 2 + 3)
      ptp = form.childAtRowCol(12, i * 2 + 3)
      mtp = form.childAtRowCol(13, i * 2 + 3)
      tot.text = stat_total[i].to_s
      ptp.text = stat_ptp[i].to_s
      mtp.text = stat_mtp[i].to_s
      if (i > 0 && stat_ptp[i - 1] != stat_ptp[i])
        ptp.backColor = "Green"
      else
        ptp.backColor = Fox.FXRGB(212, 208, 200)
      end

      if (i > 0 && stat_mtp[i - 1] != stat_mtp[i])
        mtp.backColor = "Green"
      else
        mtp.backColor = Fox.FXRGB(212, 208, 200)
      end
    }

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

  def add_tab_book(character)
    tabbook = FXTabBook.new(self, :opts => LAYOUT_FILL)

    stats_tab = FXTabItem.new(tabbook, " Stats ")
    stats_tab.font = FXFont.new(app, "Arial", 16)
    stats_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    skills_tab = FXTabItem.new(tabbook, " Skills ")
    skills_tab.font = FXFont.new(app, "Arial", 16)
    skills_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    maneuvers_tab = FXTabItem.new(tabbook, " Maneuvers ")
    maneuvers_tab.font = FXFont.new(app, "Arial", 16)
    maneuvers_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    post_cap_tab = FXTabItem.new(tabbook, " Post Cap ")
    post_cap_tab.font = FXFont.new(app, "Arial", 16)
    post_cap_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    misc_tab = FXTabItem.new(tabbook, " Misc ")
    misc_tab.font = FXFont.new(app, "Arial", 16)
    misc_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    loadout_tab = FXTabItem.new(tabbook, " Loadout ")
    loadout_tab.font = FXFont.new(app, "Arial", 16)
    loadout_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    progression_tab = FXTabItem.new(tabbook, " Progression ")
    progression_tab.font = FXFont.new(app, "Arial", 16)
    progression_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    construct_stats_page(stats_page, character)
    construct_skills_page(skills_page, character)
    construct_maneuvers_page(maneuvers_page)
    construct_post_cap_page(post_cap_page)
    construct_misc_page(misc_page)
    construct_loadout_page(loadout_page)
    construct_progression_page(progression_page)
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

  # Creates detail lines for each of the stats
  #
  # This is called in two ways.  First, it's called for each of the 10 stats, by a for loop.  Second it's called
  # from the callback function when a stat changes, so it can update all level changes
  # @param [Object] table
  # @param [String] my_stat
  # @param [Object] character Common character object
  # def create_detail_line(table, my_stat, character)
  #   rows = { str: 1, con: 2, dex: 3, agi: 4, dis: 5, aur: 6, log: 7, int: 8, wis: 9, inf: 10 }
  #
  #   bonus = character.getRace[:bonus]
  #   stats = character.getStats
  #
  #   row = rows[my_stat.to_sym]
  #
  #   my_stats = stats.getStat(my_stat)
  #   my_bonus = bonus.getStat(my_stat)
  #   my_growth = character.getGrowthIndex(my_stat)
  #
  #   table.setItemText(row, 0, create_label(my_stat, character))
  #   table.setItemJustify(row, 0, FXTableItem::LEFT)
  #   table.setColumnWidth(0, 120)
  #   table.disableItem(row, 0)
  #   table.setItemText(row, 1, my_bonus.to_s)
  #   table.disableItem(row, 1)
  #   table.setItemText(row, 2, my_growth.to_s)
  #   table.disableItem(row, 2)
  #   table.setItemText(row, 3, my_stats.to_s)
  #   table.setItemText(row, 4, my_stats.to_s)
  #   table.disableItem(row, 4)
  #
  #   growth = character.calcGrowth(my_stat)
  #   (1..MAX_COLUMNS).each { |i|
  #     table.setItemText(row, i + 4, growth[i].to_s)
  #     table.disableItem(row, i + 4)
  #     if (i > 0 && growth[i - 1] != growth[i])
  #       table.setItemStipple(row, i + 4, STIPPLE_WHITE)
  #     else
  #       table.setItemStipple(row, i + 4, STIPPLE_NONE)
  #     end
  #   }
  #
  # end

  # def construct_skills_page_old(page, character)
  #   races = Race.new
  #   my_races = races.getRaceList
  #
  #   professions = Profession.new
  #   my_professions = professions.getProfessionList
  #
  #   top_frame = FXHorizontalFrame.new(page, :opts => FRAME_LINE)
  #   form = FXMatrix.new(top_frame, 4, :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
  #
  #   FXLabel.new(form, "Select Race:")
  #   race = FXListBox.new(form, :opts => LISTBOX_NORMAL | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_X)
  #   race.numVisible = 5
  #   my_races.each { |name| race.appendItem(name) }
  #
  #   FXLabel.new(form, "Select Profession:")
  #   profession = FXListBox.new(form, :opts => LISTBOX_NORMAL | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_X)
  #   profession.numVisible = 5
  #   my_professions.each { |name| profession.appendItem(name) }
  #
  #   create_bottom_frame(page, character)
  # end

  # accounts.connect(SEL_COMMAND) do |sender, sel, data|    assign_expense_account(sender.text)
  # end
  # def create_bottom_frame(page, character)
  #
  #   table = FXTable.new(page, :opts => LAYOUT_FILL)
  #   table.tableStyle |= TABLE_NO_ROWSELECT | TABLE_NO_COLSELECT
  #   table.setTableSize(17, 15)
  #   table.rowHeaderMode = LAYOUT_FIX_WIDTH
  #   table.rowHeaderWidth = 0
  #   table.columnHeaderMode = LAYOUT_FIX_HEIGHT
  #   table.columnHeaderHeight = 0
  #
  #   (4..MAX_COLUMNS + 4).each { |row| table.setColumnWidth(row, 60) }
  #
  #   table.setItemText(0, 0, "Stats")
  #   table.stippleColor = "LawnGreen"
  #   table.setItemText(0, 1, "Race Bonus")
  #   table.setItemText(0, 2, "Growth Index")
  #   table.setItemText(0, 3, "Base")
  #   (0..MAX_COLUMNS).each { |i|
  #     table.setItemText(0, i + 4, i.to_s)
  #   }
  #
  #   stats = character.getStats
  #   stat_names = stats.getStatNames
  #
  #   # This creates the detail lines for each of the stats
  #   stat_names.each_key do |stat|
  #     create_detail_line(table, stat.to_s, character)
  #   end
  #
  #   table.connect(SEL_REPLACED) do |sender, sel, pos|
  #     table_changed(sender, sel, pos, character)
  #   end
  #
  #   labels = ["Statistics Total", "PTP", "MTP", "Experience until next level", "Total Experience", " "]
  #
  #   row_ct = 11
  #   labels.each { |label|
  #     create_bottom_row(table, label, row_ct)
  #     row_ct += 1
  #   }
  #
  #   set_totals(table, character)
  #
  #   table_health = FXTable.new(page, :opts => LAYOUT_FILL_X, :padding => 0, :height => 2)
  #   create_points(table_health, "Health", "Red")
  #
  #   table_mana = FXTable.new(page, :opts => LAYOUT_FILL_X, :padding => 0)
  #   create_points(table_mana, "Mana", "Blue")
  #
  #   table_stamina = FXTable.new(page, :opts => LAYOUT_FILL_X, :padding => 0)
  #   create_points(table_stamina, "Stamina", "Yellow")
  #
  #   table_spirit = FXTable.new(page, :opts => LAYOUT_FILL_X, :padding => 0)
  #   create_points(table_spirit, "Spirit", "Gray")
  # end

  # def create_points(table, label, stipple_color)
  #   table.tableStyle |= TABLE_NO_ROWSELECT | TABLE_NO_COLSELECT
  #   table.setTableSize(1, 15)
  #   table.rowHeaderMode = LAYOUT_FIX_WIDTH
  #   table.rowHeaderWidth = 0
  #   table.columnHeaderMode = LAYOUT_FIX_HEIGHT
  #   table.columnHeaderHeight = 0
  #   table.stippleColor = stipple_color
  #   table.marginBottom = 0
  #
  #   table.setColumnWidth(0, 120)
  #   table.setItemText(0, 0, label)
  #   table.disableItem(0, 0)
  #   spanning_item = table.getItem(0, 0)
  #   table.setItem(0, 1, spanning_item)
  #   table.setItem(0, 2, spanning_item)
  #   table.disableItem(0, 1)
  #   table.disableItem(0, 2)
  #
  #   (4..MAX_COLUMNS + 4).each do |row|
  #     table.setColumnWidth(row, 60)
  #     table.setItemText(0, row, row.to_s)
  #     table.setItemStipple(0, row, STIPPLE_WHITE)
  #   end
  # end

  # def set_totals(table, character)
  #   growth_str = character.calcGrowth("str")
  #   growth_con = character.calcGrowth("con")
  #   growth_dex = character.calcGrowth("dex")
  #   growth_agi = character.calcGrowth("agi")
  #   growth_dis = character.calcGrowth("dis")
  #   growth_aur = character.calcGrowth("aur")
  #   growth_log = character.calcGrowth("log")
  #   growth_int = character.calcGrowth("int")
  #   growth_wis = character.calcGrowth("wis")
  #   growth_inf = character.calcGrowth("inf")
  #
  #   # this is the loop that populates the 0..100 columns
  #   prev_ptp = 0
  #   prev_mtp = 0
  #   (0..MAX_COLUMNS).each { |i|
  #     stat_total = growth_str[i] + growth_con[i] + growth_dex[i] + growth_agi[i] + growth_dis[i] +
  #       growth_aur[i] + growth_log[i] + growth_int[i] + growth_wis[i] + growth_inf[i]
  #
  #     stat_ptp = character.getPtp_by_stats(growth_aur[i], growth_dis[i], growth_str[i], growth_con[i], growth_dex[i], growth_agi[i])
  #     stat_mtp = character.getMtp_by_stats(growth_aur[i], growth_dis[i], growth_log[i], growth_int[i], growth_wis[i], growth_inf[i])
  #
  #     table.setItemText(11, i + 4, stat_total.to_s)
  #     table.setItemText(12, i + 4, stat_ptp.to_s)
  #     table.setItemText(13, i + 4, stat_mtp.to_s)
  #     table.setItemText(14, i + 4, character.getExperienceByLevel(i + 1).to_s)
  #
  #     if (i > 0 && prev_ptp != stat_ptp)
  #       table.setItemStipple(12, i + 4, STIPPLE_WHITE)
  #     else
  #       table.setItemStipple(12, i + 4, STIPPLE_NONE)
  #     end
  #
  #     if (i > 0 && prev_mtp != stat_mtp)
  #       table.setItemStipple(13, i + 4, STIPPLE_WHITE)
  #     else
  #       table.setItemStipple(13, i + 4, STIPPLE_NONE)
  #     end
  #     prev_ptp = stat_ptp
  #     prev_mtp = stat_mtp
  #   }
  #
  # end

  # def table_changed(sender, sel, pos, character)
  #   rows = ["", "str", "con", "dex", "agi", "dis", "aur", "log", "int", "wis", "inf"]
  #
  #   item = sender.getItem(pos.fm.row, pos.fm.col)
  #   character.getStats.setStat(rows[pos.fm.row], item.to_s.to_i)
  #   create_detail_line(sender, rows[pos.fm.row], character)
  #   set_totals(sender, character)
  # end

  # def create_bottom_row(table, label, row)
  #   table.setItemText(row, 0, label)
  #   table.disableItem(row, 0)
  #   spanning_item = table.getItem(row, 0)
  #   table.setItem(row, 1, spanning_item)
  #   table.setItem(row, 2, spanning_item)
  #   table.disableItem(row, 1)
  #   table.disableItem(row, 2)
  #
  # end

  def construct_stats_page(page, character)
    stats = character.getStats
    stat_names = stats.getStatNames

    form = FXMatrix.new(page, MAX_COLUMNS * 2 + 4, :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    # form.borderColor = "White"
    # form.borderWidth = 2
    # form.borderColor = "White"
    mat = FXMatrix.new(form, 6, :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    mat.borderColor = "White"
    lbl = FXLabel.new(mat, "Statistic", :width => 180, :opts => LAYOUT_FIX_WIDTH | LAYOUT_FILL_X | FRAME_LINE)
    lbl.font = FXFont.new(app, "Arial", 14)
    lbl.borderColor = "White"
    FXVerticalSeparator.new(mat).shadowColor = "White"
    lbl = FXLabel.new(mat, "Race Bonus", :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE)
    lbl.font = FXFont.new(app, "Arial", 14)
    lbl.borderColor = "White"
    FXVerticalSeparator.new(mat).shadowColor = "White"
    lbl = FXLabel.new(mat, "Growth Index", :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE)
    lbl.font = FXFont.new(app, "Arial", 14)
    lbl.borderColor = "White"
    FXVerticalSeparator.new(mat).shadowColor = "White"

    lbl = FXLabel.new(form, "Base", :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y)
    lbl.borderColor = "White"
    lbl.font = FXFont.new(app, "Arial", 14)

    (0..MAX_COLUMNS).each do |i|
      FXVerticalSeparator.new(form).shadowColor = "White"
      lbl = FXLabel.new(form, i.to_s, :width => 80, :opts => FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
      lbl.borderColor = "White"
      lbl.font = FXFont.new(app, "Arial", 14)
      lbl.backColor = "Black"
      lbl.textColor = "White"
    end

    stat_names.each_key do |stat|
      create_detail_matrix(form, character, stat.to_s)
    end

    # child = form.childAtRowCol(1,0).childAtRowCol(0,0)
    # puts child.text.inspect
    create_bottom_matrix(form, character)

  end

  def create_detail_matrix(form, character, my_stat)
    # The FXMatrix layout manager automatically arranges its child windows in rows and columns.
    #   If the matrix style is MATRIX_BY_ROWS, then the matrix will have the given number of rows
    #   and the number of columns grows as more child windows are added; if the matrix style is
    #   MATRIX_BY_COLUMNS, then the number of columns is fixed and the number of rows grows as more
    #   children are added. If all children in a row (column) have the LAYOUT_FILL_ROW (LAYOUT_FILL_COLUMN)
    #   hint set, then the row (column) will be stretchable as the matrix layout manager itself is resized.
    #   If more than one row (column) is stretchable, the space is apportioned to each stretchable row (column)
    #   proportionally. Within each cell of the matrix, all other layout hints are observed. For example,
    #   a child having LAYOUT_CENTER_Y and LAYOUT_FILL_X hints will be centered in the Y-direction,
    #   being stretched in the X-direction. Empty cells can be obtained by simply placing a borderless
    #   FXFrame widget as a space-holder. Matrix packing options MATRIX_BY_ROWS: Fixed number of rows,
    #   add columns as needed MATRIX_BY_COLUMNS: Fixed number of columns, adding rows as needed

    rows = { str: 1, con: 2, dex: 3, agi: 4, dis: 5, aur: 6, log: 7, int: 8, wis: 9, inf: 10 }

    bonus = character.getRace[:bonus]
    stats = character.getStats

    row = rows[my_stat.to_sym]

    my_stats = stats.getStat(my_stat)
    my_bonus = bonus.getStat(my_stat)
    my_growth = character.getGrowthIndex(my_stat)

    mat = FXMatrix.new(form, 6, :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    mat.borderColor = "White"
    lbl = FXLabel.new(mat, create_label(my_stat, character), :width => 180, :opts => JUSTIFY_LEFT | LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_FILL_X)
    lbl.borderColor = "white"
    lbl.font = FXFont.new(app, "Arial", 14,)
    FXVerticalSeparator.new(mat).shadowColor = "White"
    lbl = FXLabel.new(mat, my_bonus.to_s, :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_FILL_X)
    lbl.borderColor = "white"
    lbl.font = FXFont.new(app, "Arial", 14)
    FXVerticalSeparator.new(mat).shadowColor = "White"
    lbl = FXLabel.new(mat, my_growth.to_s, :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_FILL_X)
    lbl.borderColor = "white"
    lbl.font = FXFont.new(app, "Arial", 14)
    FXVerticalSeparator.new(mat).shadowColor = "White"

    createTextField(form, my_stat, character)
    # lbl = FXLabel.new(form, my_stats.to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | LAYOUT_CENTER_Y | FRAME_LINE)
    # lbl.backColor = "White"
    # lbl.borderColor = "White"
    # lbl.font = FXFont.new(app, "Arial", 14)

    growth = character.calcGrowth(my_stat)
    (0..MAX_COLUMNS).each { |i|
      FXVerticalSeparator.new(form).shadowColor = "White"
      lbl = FXLabel.new(form, growth[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
      lbl.borderColor = "White"
      lbl.font = FXFont.new(app, "Arial", 14)

      lbl.backColor = "Green" if (i > 0 && growth[i - 1] != growth[i])
    }

  end

  #@ssnInput = FXTextField.new(nextFrame, 13, @ssnValue, FXDataTarget::ID_VALUE,
  # 		  LAYOUT_CENTER_Y|LAYOUT_CENTER_X|FRAME_SUNKEN|FRAME_THICK|
  # 		  LAYOUT_FILL_ROW|TEXTFIELD_ENTER_ONLY)
  #
  # # call onSsnInput when <return> is pressed.
  # @ssnInput.connect(SEL_COMMAND, method(:onSsnInput))
  #
  # FXLabel.new(nextFrame, "Entered SSN", nil,
  #        LAYOUT_CENTER_Y|LAYOUT_CENTER_X|JUSTIFY_LEFT|LAYOUT_FILL_ROW)
  #
  # # Test field to send output to.
  # @echoValue = FXDataTarget.new("");
  # @echoField = FXTextField.new(nextFrame, 13, @echoValue, FXDataTarget::ID_VALUE,
  # 	         LAYOUT_CENTER_Y|LAYOUT_CENTER_X|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_ROW)

  def createTextField(form, stat, character)
    stats = character.getStats
    my_stat = stats.getStat(stat)

    case stat
    when "str"
      str_data = FXDataTarget.new(my_stat)
      str_text = FXTextField.new(form, 4, :target => str_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      str_text.backColor = "White"
      str_text.borderColor = "White"
      str_text.font = FXFont.new(app, "Arial", 14)
      str_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(str_text)
        stat_data_changed(str_data.value, stat, character, form, my_row)
      end

    when "con"
      con_data = FXDataTarget.new(my_stat.to_s)
      con_text = FXTextField.new(form, 4, :target => con_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      con_text.backColor = "White"
      con_text.borderColor = "White"
      con_text.font = FXFont.new(app, "Arial", 14)
      con_data.connect(SEL_COMMAND) do |sender, sel, tentative|
        my_row = form.rowOfChild(con_text)
        stat_data_changed(con_data.value, stat, character, form, my_row)
      end

    when "dex"
      dex_data = FXDataTarget.new(my_stat.to_s)
      dex_text = FXTextField.new(form, 4, :target => dex_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      dex_text.backColor = "White"
      dex_text.borderColor = "White"
      dex_text.font = FXFont.new(app, "Arial", 14)
      dex_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(dex_text)
        stat_data_changed(dex_data.value, stat, character, form, my_row)
      end

    when "agi"
      agi_data = FXDataTarget.new(my_stat.to_s)
      agi_text = FXTextField.new(form, 4, :target => agi_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      agi_text.backColor = "White"
      agi_text.borderColor = "White"
      agi_text.font = FXFont.new(app, "Arial", 14)
      agi_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(agi_text)
        stat_data_changed(agi_data.value, stat, character, form, my_row)
      end

    when "dis"
      dis_data = FXDataTarget.new(my_stat.to_s)
      dis_text = FXTextField.new(form, 4, :target => dis_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      dis_text.backColor = "White"
      dis_text.borderColor = "White"
      dis_text.font = FXFont.new(app, "Arial", 14)
      dis_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(dis_text)
        stat_data_changed(dis_data.value, stat, character, form, my_row)
      end

    when "aur"
      aur_data = FXDataTarget.new(my_stat.to_s)
      aur_text = FXTextField.new(form, 4, :target => aur_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      aur_text.backColor = "White"
      aur_text.borderColor = "White"
      aur_text.font = FXFont.new(app, "Arial", 14)
      aur_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(aur_text)
        stat_data_changed(aur_data.value, stat, character, form, my_row)
      end

    when "log"
      log_data = FXDataTarget.new(my_stat.to_s)
      log_text = FXTextField.new(form, 4, :target => log_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      log_text.backColor = "White"
      log_text.borderColor = "White"
      log_text.font = FXFont.new(app, "Arial", 14)
      log_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(log_text)
        stat_data_changed(log_data.value, stat, character, form, my_row)
      end

    when "int"
      int_data = FXDataTarget.new(my_stat.to_s)
      int_text = FXTextField.new(form, 4, :target => int_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      int_text.backColor = "White"
      int_text.borderColor = "White"
      int_text.font = FXFont.new(app, "Arial", 14)
      int_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(int_text)
        stat_data_changed(int_data.value, stat, character, form, my_row)
      end

    when "wis"
      wis_data = FXDataTarget.new(my_stat.to_s)
      wis_text = FXTextField.new(form, 4, :target => wis_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      wis_text.backColor = "White"
      wis_text.borderColor = "White"
      wis_text.font = FXFont.new(app, "Arial", 14)
      wis_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(wis_text)
        # puts "Wis value is #{wis_data.value}"
        stat_data_changed(wis_data.value, stat, character, form, my_row)
      end

    when "inf"
      inf_data = FXDataTarget.new(my_stat.to_s)
      inf_text = FXTextField.new(form, 4, :target => inf_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      inf_text.backColor = "White"
      inf_text.borderColor = "White"
      inf_text.font = FXFont.new(app, "Arial", 14)
      inf_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(inf_text)
        # puts "Inf value is #{inf_data.value}"
        stat_data_changed(inf_data.value, stat, character, form, my_row)
      end
    end

  end

  def create_bottom_matrix(form, character)
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

    # this is the loop that populates the 0..100 arrays
    stat_total = []
    stat_ptp = []
    stat_mtp = []
    exp_lvl = []
    total_exp = [0]

    (0..MAX_COLUMNS).each { |i|
      stat_total[i] = growth_str[i] + growth_con[i] + growth_dex[i] + growth_agi[i] + growth_dis[i] +
        growth_aur[i] + growth_log[i] + growth_int[i] + growth_wis[i] + growth_inf[i]

      stat_ptp[i] = character.getPtp_by_stats(growth_aur[i], growth_dis[i], growth_str[i], growth_con[i], growth_dex[i], growth_agi[i])
      stat_mtp[i] = character.getMtp_by_stats(growth_aur[i], growth_dis[i], growth_log[i], growth_int[i], growth_wis[i], growth_inf[i])
      exp_lvl[i] = character.getExperienceByLevel(i + 1)

      total_exp[i] = total_exp[i - 1] + exp_lvl[i] if i > 0
    }

    totals = ["Statistics Total", "PTP", "MTP", "Experience until next level", "Total Experience", " "]
    points = ["Health", "Mana", "Stamina", "Spirit"]

    totals.each_with_index do |title, idx|
      lbl = FXLabel.new(form, title, :opts => JUSTIFY_RIGHT | LAYOUT_FILL_X)
      lbl.font = FXFont.new(app, "Arial", 14)
      # lbl.backColor = "WhiteSmoke" if idx == 5

      lbl = FXLabel.new(form, " ", :width => 80, :opts => LAYOUT_FIX_WIDTH | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
      # lbl.backColor = "WhiteSmoke" if idx == 5

      (0..MAX_COLUMNS).each do |i|
        FXVerticalSeparator.new(form).shadowColor = "White"
        if idx == 0
          lbl = FXLabel.new(form, stat_total[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.font = FXFont.new(app, "Arial", 14)
        end
        if idx == 1
          lbl = FXLabel.new(form, stat_ptp[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.font = FXFont.new(app, "Arial", 14)
          if (i > 0 && stat_ptp[i - 1] != stat_ptp[i])
            lbl.backColor = "Green"
          end
        end
        if idx == 2
          lbl = FXLabel.new(form, stat_mtp[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.font = FXFont.new(app, "Arial", 14)
          if (i > 0 && stat_mtp[i - 1] != stat_mtp[i])
            lbl.backColor = "Green"
          end
        end
        if idx == 3
          lbl = FXLabel.new(form, exp_lvl[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.backColor = "White"
          lbl.font = FXFont.new(app, "Arial", 12)
        end
        if idx == 4
          lbl = FXLabel.new(form, total_exp[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.backColor = "White"
          lbl.font = FXFont.new(app, "Arial", 12)
        end
        if idx == 5
          lbl = FXLabel.new(form, " ", :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "Gray"
          # lbl.backColor = "WhiteSmoke"
        end
      end
    end

    points.each_with_index do |title, idx|
      lbl = FXLabel.new(form, title, :opts => JUSTIFY_RIGHT | LAYOUT_FILL_X)
      lbl.font = FXFont.new(app, "Arial", 14)

      lbl = FXLabel.new(form, " ")

      (0..MAX_COLUMNS).each do |i|
        FXVerticalSeparator.new(form).shadowColor = "White"
        lbl = FXLabel.new(form, i.to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
        lbl.font = FXFont.new(app, "Arial", 14)
        lbl.borderColor = "White"
        lbl.backColor = "Red" if idx == 0
        lbl.backColor = "Blue" if idx == 1
        lbl.backColor = "Yellow" if idx == 2
        lbl.backColor = "SlateGrey" if idx == 3
        lbl.textColor = "White" if (idx == 0 || idx == 1 || idx == 3)

      end
    end
  end

  def construct_skills_page(page, character)
    form = FXMatrix.new(page, 2,
                        :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    FXLabel.new(form, "Skills page:")
  end

  def construct_maneuvers_page(page)
    form = FXMatrix.new(page, 2,
                        :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    FXLabel.new(form, "Maneuvers page:")
  end

  def construct_post_cap_page(page)
    form = FXMatrix.new(page, 2,
                        :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    FXLabel.new(form, "Post Cap page:")
  end

  def construct_misc_page(page)
    form = FXMatrix.new(page, 2,
                        :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    FXLabel.new(form, "Misc page:")
  end

  def construct_loadout_page(page)
    form = FXMatrix.new(page, 2,
                        :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    FXLabel.new(form, "Loadout page:")
  end

  def construct_progression_page(page)
    form = FXMatrix.new(page, 2,
                        :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    FXLabel.new(form, "Progression page:")
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    GS4CharacterManager.new(app)
    app.create
    app.run
  end
end
