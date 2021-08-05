class LoadoutPage
  def initialize(app)
    @app = app
  end

  def show_page(form)
    form = FXMatrix.new(form, 2,
                        :opts => MATRIX_BY_COLUMNS | LAYOUT_FILL_X)
    lbl = FXLabel.new(form, "Loadout page:")
    lbl.font = FXFont.new(@app, "Arial", 24)
  end

end