class MiscPage < FXMainWindow
  def initialize(app)
    @app = app
  end

  def show_page(form)
    tab = FXTable.new(form, :opts => LAYOUT_FILL | LAYOUT_CENTER_X)
    tab.setTableSize(10,10)
    tab.setColumnWidth(3, 275)

    # form = FXMatrix.new(form, 2, :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    # lbl = FXLabel.new(form, "Misc page:")
    # lbl.font = FXFont.new(@app, "Arial", 24)
  end
end