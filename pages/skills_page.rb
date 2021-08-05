class SkillsDialog < FXDialogBox
  def initialize(owner)
    # super(owner, "Add a Skill", DECOR_TITLE | DECOR_BORDER | DECOR_RESIZE)
  end
end

class SkillsPage
  def initialize(app)
    @app = app
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

    tab_l = FXTable.new(form_bottom, :opts => LAYOUT_FILL_X | LAYOUT_CENTER_X | LAYOUT_FILL_Y)
    tab_l.setTableSize(1, 6)
    tab_l.rowHeaderWidth = 0
    tab_l.columnHeaderFont = FXFont.new(@app, "Arial", 14)
    tab_l.columnHeaderHeight = 28

    tab_l.setColumnText(0, "Order")
    tab_l.setColumnText(1, "Skill Name")
    tab_l.setColumnText(2, "Cost & Ranks")
    tab_l.setColumnText(3, "Goal")
    tab_l.setColumnText(4, "S. lvl")
    tab_l.setColumnText(5, "Edit")

    tab_r = FXTable.new(form_bottom, :opts => LAYOUT_FILL_X | LAYOUT_CENTER_X | LAYOUT_FILL_Y)
    tab_r.setTableSize(1, 6)
    tab_r.rowHeaderWidth = 0
    tab_r.columnHeaderFont = FXFont.new(@app, "Arial", 14)
    tab_r.columnHeaderHeight = 28

    tab_r.setColumnText(0, "Skill Name")
    tab_r.setColumnText(1, "Ranks")
    tab_r.setColumnText(2, "Cost")
    tab_r.setColumnText(3, "Total Ranks")
    tab_r.setColumnText(4, "Bonus")
    tab_r.setColumnText(5, "Sum Cost")

  end
end