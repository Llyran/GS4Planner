class StatisticsPage < FXMainWindow
  MAX_COLUMNS = 15

  def initialize(app)
    @app = app
  end

  def show_page(page, character)
    stats = character.getStats
    stat_names = stats.getStatNames

    races = Race.new
    my_races = races.getRaceList

    professions = Profession.new
    my_professions = professions.getProfessionList

    frame_top = FXHorizontalFrame.new(page)
    frame_bottom = FXHorizontalFrame.new(page)
    form = FXMatrix.new(frame_bottom, MAX_COLUMNS * 2 + 4, :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)

    # This is the start of the choose race/profession dropdown container frame
    lbl = FXLabel.new(frame_top, "Choose Race: ")
    lbl.font = FXFont.new(@app, "Arial", 16)
    race = FXComboBox.new(frame_top, 10, :opts => COMBOBOX_NO_REPLACE | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_X)
    race.numVisible = my_races.length
    race.font = FXFont.new(@app, "Arial", 14)
    my_races.each { |name| race.appendItem(name) }
    race.currentItem = race.findItem(character.getRace['name'])

    race.connect(SEL_COMMAND) do |sender, sel, data|
      myRace = Race.new
      character.setRace(myRace.getRaceObjectFromDatabase(data))
      update_race_bonus(character, form)
    end

    lbl = FXLabel.new(frame_top, "Choose Profession: ")
    lbl.font = FXFont.new(@app, "Arial", 16)
    profession = FXComboBox.new(frame_top, 10, :opts => COMBOBOX_NO_REPLACE | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_X)
    profession.numVisible = my_professions.length
    profession.font = FXFont.new(@app, "Arial", 14)
    my_professions.each { |name| profession.appendItem(name) }
    profession.currentItem = profession.findItem(character.getProfession['name'])

    profession.connect(SEL_COMMAND) do |sender, sel, data|
      myProfession = Profession.new
      character.setProfession(myProfession.getProfessionObjectFromDatabase(data))
      update_growth_index(character, form)
    end

    # This is the top of the Statistics and totals/points matrix
    mat = FXMatrix.new(form, 6, :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    mat.borderColor = "White"
    lbl = FXLabel.new(mat, "Statistic", :width => 180, :opts => LAYOUT_FIX_WIDTH | LAYOUT_FILL_X | FRAME_LINE)
    lbl.font = FXFont.new(@app, "Arial", 14)
    lbl.borderColor = "White"
    FXVerticalSeparator.new(mat).shadowColor = "White"
    lbl = FXLabel.new(mat, "Race Bonus", :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE)
    lbl.font = FXFont.new(@app, "Arial", 14)
    lbl.borderColor = "White"
    FXVerticalSeparator.new(mat).shadowColor = "White"
    lbl = FXLabel.new(mat, "Growth Index", :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE)
    lbl.font = FXFont.new(@app, "Arial", 14)
    lbl.borderColor = "White"
    FXVerticalSeparator.new(mat).shadowColor = "White"

    lbl = FXLabel.new(form, "Base", :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y)
    lbl.borderColor = "White"
    lbl.font = FXFont.new(@app, "Arial", 14)

    (0..MAX_COLUMNS).each do |i|
      FXVerticalSeparator.new(form).shadowColor = "White"
      lbl = FXLabel.new(form, i.to_s, :width => 80, :opts => FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
      lbl.borderColor = "White"
      lbl.font = FXFont.new(@app, "Arial", 14)
      lbl.backColor = "Black"
      lbl.textColor = "White"
    end

    stat_names.each_key do |stat|
      create_detail_matrix(form, character, stat.to_s)
    end

    create_bottom_matrix(form, character)
  end

  private

  def stat_data_changed(val, stat, character, form, row)
    my_value = val.to_i
    return if my_value <= 20 || my_value > 100

    character.getStats.setStat(stat, my_value)
    update_data_row(stat, row, character, form)
    update_total_rows(character, form)
    update_points_rows(character, form)
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

  def update_points_rows(character, form)
    health = character.calcHealth(0)
    spirit = character.calcSpirit
    (0..MAX_COLUMNS).each do |i|
      health_label = form.childAtRowCol(17, i * 2 + 3)
      health_label.text = health[i].to_s

      spirit_label = form.childAtRowCol(20, i * 2 + 3)
      spirit_label.text = spirit[i].to_s
    end
  end

  def update_race_bonus(character, form)
    rows = { str: 1, con: 2, dex: 3, agi: 4, dis: 5, aur: 6, log: 7, int: 8, wis: 9, inf: 10 }

    bonus = character.getRace[:bonus]
    rows.each_pair do |stat, row|
      my_bonus = bonus.getStat(stat.to_s)

      child = form.childAtRowCol(row, 0)
      sub = child.childAtRowCol(0, 2)
      sub.text = my_bonus.to_s

      update_data_row(stat.to_s, row, character, form)
    end
    update_total_rows(character, form)
    update_points_rows(character, form)
  end

  def update_growth_index(character, form)
    rows = { str: 1, con: 2, dex: 3, agi: 4, dis: 5, aur: 6, log: 7, int: 8, wis: 9, inf: 10 }

    rows.each_pair do |stat, row|
      my_growth = character.getGrowthIndex(stat.to_s)

      child = form.childAtRowCol(row, 0)
      sub = child.childAtRowCol(0, 4)
      sub.text = my_growth.to_s

      update_data_row(stat.to_s, row, character, form)
    end
    update_total_rows(character, form)
    update_points_rows(character, form)
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

  # Creates the detail matrix.  This holds the stats array display code
  # @param [Object] form Main display element for the stats page
  # @param [Object] character Common character object
  # @param [Object] my_stat one of the short stat representations
  def create_detail_matrix(form, character, my_stat)
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
    lbl.font = FXFont.new(@app, "Arial", 14,)
    FXVerticalSeparator.new(mat).shadowColor = "White"
    lbl = FXLabel.new(mat, my_bonus.to_s, :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_FILL_X)
    lbl.borderColor = "white"
    lbl.font = FXFont.new(@app, "Arial", 14)
    FXVerticalSeparator.new(mat).shadowColor = "White"
    lbl = FXLabel.new(mat, my_growth.to_s, :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_FILL_X)
    lbl.borderColor = "white"
    lbl.font = FXFont.new(@app, "Arial", 14)
    FXVerticalSeparator.new(mat).shadowColor = "White"

    createTextField(form, my_stat, character)

    growth = character.calcGrowth(my_stat)
    (0..MAX_COLUMNS).each { |i|
      FXVerticalSeparator.new(form).shadowColor = "White"
      lbl = FXLabel.new(form, growth[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
      lbl.borderColor = "White"
      lbl.font = FXFont.new(@app, "Arial", 14)

      lbl.backColor = "Green" if (i > 0 && growth[i - 1] != growth[i])
    }
  end

  # This creates the input fields for each stat.  It also does basic validation (integer only), and
  # updates the stats matrix as base stat values are changed.
  # @param [Object] form Main display element for the stats page
  # @param [Object] stat One of the short stat representations
  # @param [Object] character Common character object
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
      str_text.font = FXFont.new(@app, "Arial", 14)
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
      con_text.font = FXFont.new(@app, "Arial", 14)
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
      dex_text.font = FXFont.new(@app, "Arial", 14)
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
      agi_text.font = FXFont.new(@app, "Arial", 14)
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
      dis_text.font = FXFont.new(@app, "Arial", 14)
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
      aur_text.font = FXFont.new(@app, "Arial", 14)
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
      log_text.font = FXFont.new(@app, "Arial", 14)
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
      int_text.font = FXFont.new(@app, "Arial", 14)
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
      wis_text.font = FXFont.new(@app, "Arial", 14)
      wis_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(wis_text)
        stat_data_changed(wis_data.value, stat, character, form, my_row)
      end

    when "inf"
      inf_data = FXDataTarget.new(my_stat.to_s)
      inf_text = FXTextField.new(form, 4, :target => inf_data, :selector => FXDataTarget::ID_VALUE,
                                 :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
      inf_text.backColor = "White"
      inf_text.borderColor = "White"
      inf_text.font = FXFont.new(@app, "Arial", 14)
      inf_data.connect(SEL_COMMAND) do
        my_row = form.rowOfChild(inf_text)
        stat_data_changed(inf_data.value, stat, character, form, my_row)
      end
    end

  end

  # This creates the totals containers at the bottom of the stats matrix
  # @param [Object] form
  # @param [Object] character
  def create_bottom_matrix(form, character)
    totals = ["Statistics Total", "PTP", "MTP", "Experience until next level", "Total Experience", " "]
    points = ["Health", "Mana", "Stamina", "Spirit"]

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

    totals.each_with_index do |title, idx|
      lbl = FXLabel.new(form, title, :opts => JUSTIFY_RIGHT | LAYOUT_FILL_X)
      lbl.font = FXFont.new(@app, "Arial", 14)
      # lbl.backColor = "WhiteSmoke" if idx == 5

      lbl = FXLabel.new(form, " ", :width => 80, :opts => LAYOUT_FIX_WIDTH | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
      # lbl.backColor = "WhiteSmoke" if idx == 5

      (0..MAX_COLUMNS).each do |i|
        FXVerticalSeparator.new(form).shadowColor = "White"
        if idx == 0
          lbl = FXLabel.new(form, stat_total[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.font = FXFont.new(@app, "Arial", 14)
        end
        if idx == 1
          lbl = FXLabel.new(form, stat_ptp[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.font = FXFont.new(@app, "Arial", 14)
          if (i > 0 && stat_ptp[i - 1] != stat_ptp[i])
            lbl.backColor = "Green"
          end
        end
        if idx == 2
          lbl = FXLabel.new(form, stat_mtp[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.font = FXFont.new(@app, "Arial", 14)
          if (i > 0 && stat_mtp[i - 1] != stat_mtp[i])
            lbl.backColor = "Green"
          end
        end
        if idx == 3
          lbl = FXLabel.new(form, exp_lvl[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.backColor = "White"
          lbl.font = FXFont.new(@app, "Arial", 12)
        end
        if idx == 4
          lbl = FXLabel.new(form, total_exp[i].to_s, :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.backColor = "White"
          lbl.font = FXFont.new(@app, "Arial", 12)
        end
        if idx == 5
          lbl = FXLabel.new(form, " ", :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = Fox.FXRGB(212, 208, 200)
          # lbl.backColor = "WhiteSmoke"
        end
      end
    end

    health = character.calcHealth(0)
    spirit = character.calcSpirit
    points.each_with_index do |title, idx|
      lbl = FXLabel.new(form, title, :opts => JUSTIFY_RIGHT | LAYOUT_FILL_X)
      lbl.font = FXFont.new(@app, "Arial", 14)

      lbl = FXLabel.new(form, " ")

      (0..MAX_COLUMNS).each do |i|
        FXVerticalSeparator.new(form).shadowColor = "White"
        lbl = FXLabel.new(form, i.to_s, :width => 80,
                          :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)

        lbl.text = health[i].to_s if (title == "Health")
        lbl.text = spirit[i].to_s if (title == "Spirit")

        lbl.font = FXFont.new(@app, "Arial", 14)
        lbl.borderColor = "White"
        lbl.backColor = "Red" if idx == 0
        lbl.backColor = "Blue" if idx == 1
        lbl.backColor = "Yellow" if idx == 2
        lbl.backColor = "SlateGrey" if idx == 3
        lbl.textColor = "White" if (idx == 0 || idx == 1 || idx == 3)

      end
    end
  end

end