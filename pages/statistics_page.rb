require "./lib/classes/Stat"

class StatisticsPage < FXMainWindow
  MAX_COLUMNS = 100

  def initialize(app)
    @app = app
  end

  def show_page(page, character)
    # GS4CharacterManager.statsStorage[:test] = Array['test']
    # puts GS4CharacterManager.statsStorage.inspect

    stats = character.getStats
    stat_names = stats.getStatNames

    races = Race.new
    my_races = races.getRaceList

    professions = Profession.new
    my_professions = professions.getProfessionList

    # Set up the display chain
    # Frametop holds race and profession chooser
    frame_top = FXHorizontalFrame.new(page)

    # frame_stats holds everything else
    frame_stats = FXHorizontalFrame.new(page)

    matrix_frame = FXMatrix.new(frame_stats, 1, :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    matrixL = FXMatrix.new(matrix_frame, 4, :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    scroll_window = FXScrollWindow.new(frame_stats, LAYOUT_FILL_X | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH | LAYOUT_FIX_HEIGHT, :width => 1140, :height => 710)
    matrixR = FXMatrix.new(scroll_window, MAX_COLUMNS + 1, MATRIX_BY_COLUMNS)

    # This is the start of the choose race/profession dropdown container frame
    lbl = FXLabel.new(frame_top, "Choose Race: ")
    lbl.font = FXFont.new(@app, "Arial", 16)
    race = FXComboBox.new(frame_top, 10, :opts => COMBOBOX_NO_REPLACE | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_X)
    race.numVisible = my_races.length
    race.font = FXFont.new(@app, "Arial", 14)
    my_races.each { |name| race.appendItem(name) }
    race.currentItem = race.findItem(character.getRace['name'])

    race.connect(SEL_COMMAND) { |sender, sel, data|
      myRace = Race.new
      character.setRace(myRace.getRaceObjectFromDatabase(data))
      update_race_bonus(character, matrixL, matrixR)
    }

    lbl = FXLabel.new(frame_top, "Choose Profession: ")
    lbl.font = FXFont.new(@app, "Arial", 16)
    profession = FXComboBox.new(frame_top, 10, :opts => COMBOBOX_NO_REPLACE | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_X)
    profession.numVisible = my_professions.length
    profession.font = FXFont.new(@app, "Arial", 14)
    my_professions.each { |name| profession.appendItem(name) }
    profession.currentItem = profession.findItem(character.getProfession['name'])

    profession.connect(SEL_COMMAND) { |sender, sel, data|
      myProfession = Profession.new
      character.setProfession(myProfession.getProfessionObjectFromDatabase(data))
      update_growth_index(character, matrixL, matrixR)
      update_lables(character, matrixL)
    }

    # TOP OF STATISTICS COLUMNS
    # Nonscrolling region, left section of display
    #   This is the top of the Statistics and totals/points matrix
    matrixL.borderColor = "White"

    lbl = FXLabel.new(matrixL, "Statistic", :width => 180, :opts => LAYOUT_FIX_WIDTH | LAYOUT_FILL_X | FRAME_LINE)
    lbl.font = FXFont.new(@app, "Arial", 14)
    lbl.borderColor = "White"

    lbl = FXLabel.new(matrixL, "Race Bonus", :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE)
    lbl.font = FXFont.new(@app, "Arial", 14)
    lbl.borderColor = "White"

    lbl = FXLabel.new(matrixL, "Growth Index", :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE)
    lbl.font = FXFont.new(@app, "Arial", 14)
    lbl.borderColor = "White"

    lbl = FXLabel.new(matrixL, "Base", :width => 80, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y)
    lbl.borderColor = "White"
    lbl.font = FXFont.new(@app, "Arial", 14)

    # Scrolling region, right section of display
    (0..MAX_COLUMNS).each { |i|
      lbl = FXLabel.new(matrixR, i.to_s, :width => 100, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
      lbl.borderColor = "White"
      lbl.font = FXFont.new(@app, "Arial", 14)
      lbl.backColor = "Black"
      lbl.textColor = "White"
    }

    stat_names.each_key { |stat|
      create_detail_matrix(matrixL, matrixR, character, stat.to_s)
    }

    create_bottom_matrix(matrix_frame, matrixR, character)
  end

  private

  def stat_data_changed(val, stat, character, matrixR, row)
    my_value = val.to_i
    return if my_value < 20 || my_value > 100

    character.getStats.setStat(stat, my_value)

    recalc_stat_data(character, stat, my_value)

    update_data_row(stat, row, character, matrixR)
    update_total_rows(character, matrixR)
    update_points_rows(character, matrixR)
  end

  def recalc_stat_data(character, stat, value)
    professionGrowth = character.getProfession[:growth].getStat(stat)
    raceAdjust = character.getRace[:adjust].getStat(stat)
    raceModifier = character.getRace[:bonus].getStat(stat)

    growth_interval = professionGrowth + raceAdjust

    storeIt = Stat.new(stat, value, growth_interval, raceModifier)
    growth = storeIt.calcGrowth

    GS4CharacterManager.statsStorage[stat.to_sym] = growth
  end

  def update_data_row(stat, row, character, matrixR)
    (0..MAX_COLUMNS).each { |index|
      cell = matrixR.childAtRowCol(row, index)
      cell.text = GS4CharacterManager.statsStorage[stat.to_sym][:growth][index].to_s + "  (" +
        GS4CharacterManager.statsStorage[stat.to_sym][:bonus][index].to_s + ")"

      if (index > 0 && GS4CharacterManager.statsStorage[stat.to_sym][:growth][index - 1] != GS4CharacterManager.statsStorage[stat.to_sym][:growth][index])
        cell.backColor = "Green"
      else
        cell.backColor = Fox.FXRGB(212, 208, 200)
      end

    }
  end

  def update_data_rows(character)
    rows = { str: 1, con: 2, dex: 3, agi: 4, dis: 5, aur: 6, log: 7, int: 8, wis: 9, inf: 10 }

    rows.each_key { |stat|
      professionGrowth = character.getProfession[:growth].getStats[stat]
      raceAdjust = character.getRace[:adjust].getStats[stat]
      growth_interval = professionGrowth + raceAdjust

      raceModifier = character.getRace[:bonus].getStats[stat]

      myStart = character.getStats.getStat(stat.to_s)

      storeIt = Stat.new(stat, myStart, growth_interval, raceModifier)
      growth = storeIt.calcGrowth

      GS4CharacterManager.statsStorage[stat] = growth
    }

  end

  def update_total_rows(character, matrixR)
    # this is the loop that populates the 0..100 arrays
    stat_total = []
    stat_ptp = []
    stat_mtp = []

    (0..MAX_COLUMNS).each { |i|
      growth_str = GS4CharacterManager.statsStorage[:str][:growth][i]
      growth_con = GS4CharacterManager.statsStorage[:con][:growth][i]
      growth_dex = GS4CharacterManager.statsStorage[:dex][:growth][i]
      growth_agi = GS4CharacterManager.statsStorage[:agi][:growth][i]
      growth_dis = GS4CharacterManager.statsStorage[:dis][:growth][i]
      growth_aur = GS4CharacterManager.statsStorage[:aur][:growth][i]
      growth_log = GS4CharacterManager.statsStorage[:log][:growth][i]
      growth_int = GS4CharacterManager.statsStorage[:int][:growth][i]
      growth_wis = GS4CharacterManager.statsStorage[:wis][:growth][i]
      growth_inf = GS4CharacterManager.statsStorage[:inf][:growth][i]
      stat_total[i] = growth_str + growth_con + growth_dex + growth_agi + growth_dis +
        growth_aur + growth_log + growth_int + growth_wis + growth_inf

      # TODO Figure out a way to do this in bulk, instead of inside a loop
      stat_ptp[i] = character.getPtp_by_stats(growth_aur, growth_dis, growth_str, growth_con, growth_dex, growth_agi)
      stat_mtp[i] = character.getMtp_by_stats(growth_aur, growth_dis, growth_log, growth_int, growth_wis, growth_inf)

      tot = matrixR.childAtRowCol(11, i)
      ptp = matrixR.childAtRowCol(12, i)
      mtp = matrixR.childAtRowCol(13, i)
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

  def update_points_rows(character, matrixR)
    health = character.calcHealth(0)
    spirit = character.calcSpirit
    (0..MAX_COLUMNS).each { |i|
      health_label = matrixR.childAtRowCol(17, i)
      health_label.text = health[i].to_s

      spirit_label = matrixR.childAtRowCol(20, i)
      spirit_label.text = spirit[i].to_s
    }
  end

  def update_race_bonus(character, matrixL, matrixR)
    rows = { str: 1, con: 2, dex: 3, agi: 4, dis: 5, aur: 6, log: 7, int: 8, wis: 9, inf: 10 }

    bonus = character.getRace[:bonus]
    rows.each_pair { |stat, row|
      my_bonus = bonus.getStat(stat.to_s)

      sub = matrixL.childAtRowCol(row, 1)
      sub.text = my_bonus.to_s

      myStart = character.getStats.getStat(stat.to_s)
      recalc_stat_data(character, stat.to_s, myStart)
      update_data_row(stat.to_s, row, character, matrixR)
    }

    update_data_rows(character)
    update_total_rows(character, matrixR)
    update_points_rows(character, matrixR)

  end

  def update_growth_index(character, matrixL, matrixR)
    rows = { str: 1, con: 2, dex: 3, agi: 4, dis: 5, aur: 6, log: 7, int: 8, wis: 9, inf: 10 }

    rows.each_pair { |stat, row|
      my_growth = character.getGrowthIndex(stat.to_s)

      sub = matrixL.childAtRowCol(row, 2)
      sub.text = my_growth.to_s

      myStart = character.getStats.getStat(stat.to_s)
      recalc_stat_data(character, stat.to_s, myStart)
      update_data_row(stat.to_s, row, character, matrixR)
    }

    update_data_rows(character)
    update_total_rows(character, matrixR)
    update_points_rows(character, matrixR)
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
  # @param [Object] matrixL Main display element for the stats page
  # @param [Object] matrixR Main display element for the stats page
  # @param [Object] character Common character object
  # @param [Object] my_stat one of the short stat representations
  def create_detail_matrix(matrixL, matrixR, character, my_stat)
    bonus = character.getRace[:bonus]
    my_bonus = bonus.getStat(my_stat)
    my_growth = character.getGrowthIndex(my_stat)

    lbl = FXLabel.new(matrixL, create_label(my_stat, character), :width => 180, :opts => JUSTIFY_LEFT | LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_FILL_X)
    lbl.borderColor = "white"
    lbl.font = FXFont.new(@app, "Arial", 14,)
    lbl = FXLabel.new(matrixL, my_bonus.to_s, :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_FILL_X)
    lbl.borderColor = "white"
    lbl.font = FXFont.new(@app, "Arial", 14)
    lbl = FXLabel.new(matrixL, my_growth.to_s, :width => 120, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_FILL_X)
    lbl.borderColor = "white"
    lbl.font = FXFont.new(@app, "Arial", 14)
    createTextField(matrixL, matrixR, my_stat, character)

    (0..MAX_COLUMNS).each { |index|
      myText = GS4CharacterManager.statsStorage[my_stat.to_sym][:growth][index].to_s + "  (" +
        GS4CharacterManager.statsStorage[my_stat.to_sym][:bonus][index].to_s + ")"

      lbl = FXLabel.new(matrixR, myText, :width => 100, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
      lbl.borderColor = "White"
      lbl.font = FXFont.new(@app, "Arial", 14)

      lbl.backColor = "Green" if (index > 0 && GS4CharacterManager.statsStorage[my_stat.to_sym][:growth][index - 1] != GS4CharacterManager.statsStorage[my_stat.to_sym][:growth][index])
    }
  end

  # This creates the input fields for each stat.  It also does basic validation (integer only), and
  # updates the stats matrix as base stat values are changed.
  # @param [Object] matrixL Main display element for the stats page
  # @param [Object] matrixR Main display element for the stats page
  # @param [Object] stat One of the short stat representations
  # @param [Object] character Common character object
  def createTextField(matrixL, matrixR, stat, character)
    stats = character.getStats
    my_stat = stats.getStat(stat)

    case stat
    when "str"
      str_data = FXDataTarget.new(my_stat.to_s)
      str_text = create_data_field(str_data, matrixL)

      str_data.connect(SEL_COMMAND) do
        my_row = matrixL.rowOfChild(str_text)
        stat_data_changed(str_data.value, stat, character, matrixR, my_row)
      end

    when "con"
      con_data = FXDataTarget.new(my_stat.to_s)
      con_text = create_data_field(con_data, matrixL)

      con_data.connect(SEL_COMMAND) { |sender, sel, tentative|
        my_row = matrixL.rowOfChild(con_text)
        stat_data_changed(con_data.value, stat, character, matrixR, my_row)
      }

    when "dex"
      dex_data = FXDataTarget.new(my_stat.to_s)
      dex_text = create_data_field(dex_data, matrixL)

      dex_data.connect(SEL_COMMAND) do
        my_row = matrixL.rowOfChild(dex_text)
        stat_data_changed(dex_data.value, stat, character, matrixR, my_row)
      end

    when "agi"
      agi_data = FXDataTarget.new(my_stat.to_s)
      agi_text = create_data_field(agi_data, matrixL)

      agi_data.connect(SEL_COMMAND) do
        my_row = matrixL.rowOfChild(agi_text)
        stat_data_changed(agi_data.value, stat, character, matrixR, my_row)
      end

    when "dis"
      dis_data = FXDataTarget.new(my_stat.to_s)
      dis_text = create_data_field(dis_data, matrixL)

      dis_data.connect(SEL_COMMAND) do
        my_row = matrixL.rowOfChild(dis_text)
        stat_data_changed(dis_data.value, stat, character, matrixR, my_row)
      end

    when "aur"
      aur_data = FXDataTarget.new(my_stat.to_s)
      aur_text = create_data_field(aur_data, matrixL)

      aur_data.connect(SEL_COMMAND) do
        my_row = matrixL.rowOfChild(aur_text)
        stat_data_changed(aur_data.value, stat, character, matrixR, my_row)
      end

    when "log"
      log_data = FXDataTarget.new(my_stat.to_s)
      log_text = create_data_field(log_data, matrixL)

      log_data.connect(SEL_COMMAND) do
        my_row = matrixL.rowOfChild(log_text)
        stat_data_changed(log_data.value, stat, character, matrixR, my_row)
      end

    when "int"
      int_data = FXDataTarget.new(my_stat.to_s)
      int_text = create_data_field(int_data, matrixL)

      int_data.connect(SEL_COMMAND) do
        my_row = matrixL.rowOfChild(int_text)
        stat_data_changed(int_data.value, stat, character, matrixR, my_row)
      end

    when "wis"
      wis_data = FXDataTarget.new(my_stat.to_s)
      wis_text = create_data_field(wis_data, matrixL)

      wis_data.connect(SEL_COMMAND) do
        my_row = matrixL.rowOfChild(wis_text)
        stat_data_changed(wis_data.value, stat, character, matrixR, my_row)
      end

    when "inf"
      inf_data = FXDataTarget.new(my_stat.to_s)
      inf_text = create_data_field(inf_data, matrixL)

      inf_data.connect(SEL_COMMAND) do
        my_row = matrixL.rowOfChild(inf_text)
        stat_data_changed(inf_data.value, stat, character, matrixR, my_row)
      end
    end

  end

  def create_data_field(data_field, matrixL)
    myTextField = FXTextField.new(matrixL, 4, :target => data_field, :selector => FXDataTarget::ID_VALUE,
                                  :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
    myTextField.backColor = "White"
    myTextField.borderColor = "White"
    myTextField.font = FXFont.new(@app, "Arial", 14)

    myTextField
  end

  # This creates the totals containers at the bottom of the stats matrix
  # @param [Object] matrixR
  # @param [Object] character
  def create_bottom_matrix(mat_frame, matrixR, character)
    totals = ["Statistics Total", "PTP", "MTP", "Experience until next level", "Total Experience", " "]
    points = ["Health", "Mana", "Stamina", "Spirit"]

    # this is the loop that populates the 0..100 arrays
    stat_total = []
    stat_ptp = []
    stat_mtp = []
    exp_lvl = []
    total_exp = [0]

    (0..MAX_COLUMNS).each { |i|
      growth_str = GS4CharacterManager.statsStorage[:str][:growth][i]
      growth_con = GS4CharacterManager.statsStorage[:con][:growth][i]
      growth_dex = GS4CharacterManager.statsStorage[:dex][:growth][i]
      growth_agi = GS4CharacterManager.statsStorage[:agi][:growth][i]
      growth_dis = GS4CharacterManager.statsStorage[:dis][:growth][i]
      growth_aur = GS4CharacterManager.statsStorage[:aur][:growth][i]
      growth_log = GS4CharacterManager.statsStorage[:log][:growth][i]
      growth_int = GS4CharacterManager.statsStorage[:int][:growth][i]
      growth_wis = GS4CharacterManager.statsStorage[:wis][:growth][i]
      growth_inf = GS4CharacterManager.statsStorage[:inf][:growth][i]

      stat_total[i] = growth_str + growth_con + growth_dex + growth_agi + growth_dis +
        growth_aur + growth_log + growth_int + growth_wis + growth_inf

      stat_ptp[i] = character.getPtp_by_stats(growth_aur, growth_dis, growth_str, growth_con, growth_dex, growth_agi)
      stat_mtp[i] = character.getMtp_by_stats(growth_aur, growth_dis, growth_log, growth_int, growth_wis, growth_inf)
      exp_lvl[i] = character.getExperienceByLevel(i + 1)

      total_exp[i] = total_exp[i - 1] + exp_lvl[i] if i > 0
    }

    totals.each_with_index { |title, idx|
      lbl = FXLabel.new(mat_frame, title, :opts => JUSTIFY_RIGHT | LAYOUT_FILL_X)
      lbl.font = FXFont.new(@app, "Arial", 14)

      (0..MAX_COLUMNS).each { |i|
        if idx == 0
          lbl = FXLabel.new(matrixR, stat_total[i].to_s, :width => 100, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.font = FXFont.new(@app, "Arial", 14)
        end
        if idx == 1
          lbl = FXLabel.new(matrixR, stat_ptp[i].to_s, :width => 100, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.font = FXFont.new(@app, "Arial", 14)
          if (i > 0 && stat_ptp[i - 1] != stat_ptp[i])
            lbl.backColor = "Green"
          end
        end
        if idx == 2
          lbl = FXLabel.new(matrixR, stat_mtp[i].to_s, :width => 100, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.font = FXFont.new(@app, "Arial", 14)
          if (i > 0 && stat_mtp[i - 1] != stat_mtp[i])
            lbl.backColor = "Green"
          end
        end
        if idx == 3
          lbl = FXLabel.new(matrixR, exp_lvl[i].to_s, :width => 100, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.backColor = "White"
          lbl.font = FXFont.new(@app, "Arial", 12)
        end
        if idx == 4
          lbl = FXLabel.new(matrixR, total_exp[i].to_s, :width => 100, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = "White"
          lbl.backColor = "White"
          lbl.font = FXFont.new(@app, "Arial", 12)
        end
        if idx == 5
          lbl = FXLabel.new(matrixR, " ", :width => 100, :opts => LAYOUT_FIX_WIDTH | FRAME_LINE | LAYOUT_CENTER_Y | LAYOUT_CENTER_X | LAYOUT_FILL_X)
          lbl.borderColor = Fox.FXRGB(212, 208, 200)
          # lbl.backColor = "WhiteSmoke"
        end
      }
    }

    health = character.calcHealth(0)
    spirit = character.calcSpirit
    points.each_with_index { |title, idx|
      lbl = FXLabel.new(mat_frame, title, :opts => JUSTIFY_RIGHT | LAYOUT_FILL_X)
      lbl.font = FXFont.new(@app, "Arial", 14)

      (0..MAX_COLUMNS).each { |i|
        lbl = FXLabel.new(matrixR, i.to_s, :width => 100,
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

      }
    }
  end

  def update_lables(character, matrixL)
    rows = { str: 1, con: 2, dex: 3, agi: 4, dis: 5, aur: 6, log: 7, int: 8, wis: 9, inf: 10 }

    stats = character.getStats
    stat_names = stats.getStatNames

    stat_names.each_key { |stat|
      myText = create_label(stat, character)
      row = rows[stat.to_sym]

      sub = matrixL.childAtRowCol(row, 0)
      sub.text = myText
    }
  end
end