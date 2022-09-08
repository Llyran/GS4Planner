require "./lib/classes/Training"
require "./lib/classes/Skills"
require 'fox16'
include Fox

class SkillsDialog < FXDialogBox

  attr_accessor :skill_attr

  def initialize(owner, character)
    # Invoke base class initialize function first
    super(owner, "Add a Skill", DECOR_TITLE | DECOR_BORDER)

    @skill_attr = {
      :skill_name => FXDataTarget.new(" "),
      :cost => FXDataTarget.new(" "),
      :goal => FXDataTarget.new(" "),
      :start => FXDataTarget.new(0),
      :target => FXDataTarget.new(100),
      :total_ranks => FXDataTarget.new(0),
      :order => FXDataTarget.new(1)
    }

    skills = Skills.new
    training = Training.new

    my_skills = skills.getSkillsList(character.getProfession['name'])
    my_skills.unshift('Choose a skill')

    # dialog box frame
    dialog_box = FXMatrix.new(self, 2, :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)

    # First row Skills chooser
    lbl = FXLabel.new(dialog_box, "Skill Name ")
    lbl.font = FXFont.new(getApp(), "Arial", 14)

    skills_box = FXComboBox.new(dialog_box, 25, :target => @skill_attr[:skill_name], :opts => COMBOBOX_NO_REPLACE | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_X)
    skills_box.numVisible = my_skills.length

    skills_box.font = FXFont.new(getApp(), "Arial", 14)
    my_skills.each { |name| skills_box.appendItem(name) }

    skills_box.connect(SEL_COMMAND) { |sender, sel, data|
      # handler for adding skills
      break if data == 'Choose a skill'
      profession = character.getProfession['name']

      @skill_attr[:skill_name].value = data
      skillsInfo = training.getTrainingCost(data, profession)

      box = dialog_box.childAtRowCol(1, 1)
      @skill_attr[:cost].value = skillsInfo['ptp'].to_s + ' / ' + skillsInfo['mtp'].to_s + ' (' + skillsInfo['ranks'].to_s + ')'
      box.text = @skill_attr[:cost].value
    }

    # Cost and Ranks display
    lbl = FXLabel.new(dialog_box, "Cost & Ranks")
    lbl.font = FXFont.new(getApp(), "Arial", 14)

    cost = " "
    lbl = FXLabel.new(dialog_box, cost)
    lbl.font = FXFont.new(getApp(), "Arial", 14)
    lbl.backColor = "AntiqueWhite2"

    # Seperator
    lbl = FXLabel.new(dialog_box, " ")
    lbl = FXLabel.new(dialog_box, " ")

    # Training Order
    # TODO Once we have a list of skills, this needs to (1..skills.length)
    #
    my_count = character.getTraining.length

    lbl = FXLabel.new(dialog_box, "Training Order")
    lbl.font = FXFont.new(getApp(), "Arial", 14)

    training_order_box = FXComboBox.new(dialog_box, 7, :target => @skill_attr[:order], :opts => COMBOBOX_NO_REPLACE | FRAME_SUNKEN | FRAME_THICK)
    training_order_box.numVisible = my_count
    training_order_box.font = FXFont.new(getApp(), "Arial", 14)

    (1..my_count).each { |count| training_order_box.appendItem(count.to_s) }

    # Seperator
    lbl = FXLabel.new(dialog_box, " ")
    lbl = FXLabel.new(dialog_box, " ")

    # training goals
    lbl = FXLabel.new(dialog_box, "Goal")
    lbl.font = FXFont.new(getApp(), "Arial", 14)

    goal = FXTextField.new(dialog_box, 4, :target => @skill_attr[:goal], :selector => FXDataTarget::ID_VALUE,
                           :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE)
    goal.font = FXFont.new(getApp(), "Arial", 14)

    # Seperator
    lbl = FXLabel.new(dialog_box, " ")
    lbl = FXLabel.new(dialog_box, " ")

    #training range
    lbl = FXLabel.new(dialog_box, "Level Range")
    lbl.font = FXFont.new(getApp(), "Arial", 14)

    range = FXHorizontalFrame.new(dialog_box, :opts => LAYOUT_FILL_X)

    lbl = FXLabel.new(range, "Start")
    lbl.font = FXFont.new(getApp(), "Arial", 14)
    range_start = FXTextField.new(range, 3, :target => @skill_attr[:start], :selector => FXDataTarget::ID_VALUE,
                                  :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
    range_start.font = FXFont.new(getApp(), "Arial", 14)

    lbl = FXLabel.new(range, "Target")
    lbl.font = FXFont.new(getApp(), "Arial", 14)
    range_target = FXTextField.new(range, 3, :target => @skill_attr[:target], :selector => FXDataTarget::ID_VALUE,
                                   :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE | TEXTFIELD_INTEGER)
    range_target.font = FXFont.new(getApp(), "Arial", 14)

    lbl = FXLabel.new(dialog_box, "Total Ranks")
    lbl.font = FXFont.new(getApp(), "Arial", 14)

    total_ranks = FXTextField.new(dialog_box, 4, :target => @skill_attr[:total_ranks], :selector => FXDataTarget::ID_VALUE,
                                  :opts => JUSTIFY_RIGHT | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | FRAME_LINE)
    total_ranks.font = FXFont.new(getApp(), "Arial", 14)

    # Seperator
    lbl = FXLabel.new(dialog_box, " ")
    lbl = FXLabel.new(dialog_box, " ")

    # Seperator
    lbl = FXLabel.new(dialog_box, " ")
    lbl = FXLabel.new(dialog_box, " ")

    # Accept
    accept = FXButton.new(dialog_box, "&Add Skill", nil, self, ID_ACCEPT,
                          FRAME_RAISED | FRAME_THICK | LAYOUT_CENTER_X | LAYOUT_CENTER_Y)
    accept.font = FXFont.new(getApp(), "Arial", 14)

    # Cancel
    cancel = FXButton.new(dialog_box, "&Cancel", nil, self, ID_CANCEL,
                          FRAME_RAISED | FRAME_THICK | LAYOUT_CENTER_X | LAYOUT_CENTER_Y)
    cancel.font = FXFont.new(getApp(), "Arial", 14)

    accept.setDefault
    accept.setFocus
  end
end

class SkillsPage < FXMainWindow
  def initialize(app)
    @app = app
    super(app, "")
  end

  def show_page(page, character)
    form_top = FXHorizontalFrame.new(page, :opts => LAYOUT_FILL_X)
    add_button = FXButton.new(form_top, "Add Skill")
    add_button.font = FXFont.new(@app, "Arial", 14)

    calc_button = FXButton.new(form_top, "Calculate Build")
    calc_button.font = FXFont.new(@app, "Arial", 14)
    clear_button = FXButton.new(form_top, "Clear Skills")
    clear_button.font = FXFont.new(@app, "Arial", 14)
    form_bottom = FXHorizontalFrame.new(page, :opts => LAYOUT_FILL_X | LAYOUT_FILL_Y)

    tab_l = FXTable.new(form_bottom, :opts => LAYOUT_FILL)
    tab_l.setTableSize(0, 7)
    tab_l.rowHeaderWidth = 0
    tab_l.columnHeaderFont = FXFont.new(@app, "Arial", 14)
    tab_l.font = FXFont.new(@app, "Arial", 14)
    tab_l.columnHeaderHeight = 28

    [60, 300, 140, 60, 60, 60, 60].each_with_index { |width, index|
      tab_l.setColumnWidth(index, width)
      tab_l.setColumnJustify(index, FXTableItem::CENTER_X)
    }

    ["Order", "Skill Name", "Cost & Ranks", "Goal", "S. lvl", "T. lvl", "Edit"].each_with_index { |myText, index|
      tab_l.setColumnText(index, myText)
    }

    tab_r = FXTable.new(form_bottom, :opts => LAYOUT_FILL)
    tab_r.setTableSize(0, 6)
    tab_r.rowHeaderWidth = 0
    tab_r.columnHeaderFont = FXFont.new(@app, "Arial", 14)
    tab_r.font = FXFont.new(@app, "Arial", 14)
    tab_r.columnHeaderHeight = 28

    [300, 80, 60, 120, 80, 100].each_with_index { |width, index|
      tab_r.setColumnWidth(index, width)
      tab_r.setColumnJustify(index, FXTableItem::CENTER_X)
    }

    ["Skill Name", "Ranks", "Cost", "Total Ranks", "Bonus", "Sum Cost"].each_with_index { |myText, index|
      tab_r.setColumnText(index, myText)
    }

    add_button.connect(SEL_COMMAND) { |sender, sel, ptr|

      dialog = SkillsDialog.new(self, character)

      # This is how we populate information into the dialog box.
      # dialog.skill_attr[:goal].value = "3"

      if dialog.execute != 0
        training = Training.new

        training.addTrainingSkill(
          dialog.skill_attr[:skill_name].value,
          dialog.skill_attr[:cost].value,
          dialog.skill_attr[:goal].value,
          dialog.skill_attr[:start].value,
          dialog.skill_attr[:target].value,
          dialog.skill_attr[:order].value)
        character.addTraining(training.getTraining)

        tab_l.appendRows
        r = tab_l.numRows - 1

        add_skill_display_row(dialog.skill_attr, r, tab_l)
      end
    }

    load_skill_section(character.getTraining, tab_l)
  end

  private

  def add_skill_display_row(skill_attr, row, table)
    table.setRowHeight(row, 28)
    table.setItemText(row, 0, skill_attr[:order].to_s)
    table.setItemJustify(row, 0, FXTableItem::CENTER_X)

    table.setItemText(row, 1, skill_attr[:skill_name].to_s)
    table.setItemJustify(row, 1, FXTableItem::LEFT)

    table.setItemText(row, 2, skill_attr[:cost].to_s)
    table.setItemJustify(row, 2, FXTableItem::CENTER_X)

    table.setItemText(row, 3, skill_attr[:goal].to_s)
    table.setItemJustify(row, 3, FXTableItem::CENTER_X)

    table.setItemText(row, 4, skill_attr[:start].to_s)
    table.setItemJustify(row, 4, FXTableItem::CENTER_X)

    table.setItemText(row, 5, skill_attr[:target].to_s)
    table.setItemJustify(row, 5, FXTableItem::CENTER_X)

    table.setItemText(row, 6, 'Edit')
    table.setItemJustify(row, 6, FXTableItem::CENTER_X)
  end

  def load_skill_section(training, tab_l)
    training.each { |localTraining|
      tab_l.appendRows
      r = tab_l.numRows - 1

      add_skill_display_row(localTraining, r, tab_l)
    }
  end
end