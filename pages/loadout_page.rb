class LoadoutPage < FXMainWindow
  def initialize(app)
    @app = app
  end

  def show_page(page)
    frame = FXHorizontalFrame.new(page)
    # Nonscrolling region, left section of display
    matrix = FXMatrix.new(frame, 3, MATRIX_BY_ROWS)

    # Scrolling region, right section of display
    scroll_window = FXScrollWindow.new(frame, LAYOUT_FILL_X|LAYOUT_FILL_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 800, :height =>121)
    matrix2 = FXMatrix.new(scroll_window, 3, MATRIX_BY_ROWS)

  end

end