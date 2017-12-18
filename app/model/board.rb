class Board
  
  attr_accessor :rows, :cols, :cells
  
  def initialize(rows, columns)
    @rows = rows
    @cols = columns
    @cells = Array.new(@rows) {Array.new(@cols, 0)}
    @generation = 0
    @repeat_count = 0
    @last_cells = nil
  end
  
  def get_cell(row, col)
    return nil unless is_cell(row, col)
    @cells[row][col]
  end
  
  def set_cell(row, col, state)
    @cells[row][col] = state
  end
  
  def set_board(live_arr)
    live_arr.each do |coords|
      set_cell(coords[0], coords[1], 1)
    end
  end
  
  # 0 1 2
  # 3 • 4
  # 5 6 7
  def get_neighbors(row, col)
    neighbors = 0
    ((row-1)..(row+1)).each do |r|
      ((col-1)..(col+1)).each do |c|
        state = get_cell(r, c)
        neighbors += state if state
      end
    end
    # Remove myself if I am alive
    neighbors = neighbors - get_cell(row, col)
  end
  
  def is_cell(row, col)
    (row >= 0 && row < @rows) && (col >= 0 && col < @cols)
  end
  
  def next_gen
    @generation += 1
    next_board = Board.new(@rows, @cols)
    @cells.each_with_index do |row, r|
      row.each_with_index do |cell, c|
        next_board.set_cell(r, c, get_next_state(c, r))
      end
    end
    
    # Next Gen is the same as current gen
    frozen_board = @generation > 5 && @cells == next_board.cells
    
    # If we see a repeat of the prior board, it is a blinker
    blinker_board = @generation > 5 && next_board.cells == @last_cells

    @last_cells = @cells # For detecting oscillatory blinker state
    @cells = next_board.cells # Reset the current state

    puts "FROZEN STATE DETECTED @#{@generation}" if frozen_board
    puts "BLINKER STATE DETECTED @#{@generation}" if blinker_board & !frozen_board
    if blinker_board
      @repeat_count += 1
    end
    !(@repeat_count > 5)
  end
  
  def show
    STDERR.print "\e[2J\e[f" # Magic to clear screen (possibly works only in *nix)
    # puts '*' * (@cols + 4)
    txt = ''
    @cells.each_with_index do |row, r|
      row.each_with_index do |cell, c|
        txt += "| #{cell == 1 ? '•' : ' '} "
      end
      txt += "|\n"
      # puts "#{txt}|\n"
    end
    print txt
  end
  
  def get_next_state(c, r)
    neighbors = get_neighbors(r, c)
    state = 0
    if is_alive?(c, r)
      if neighbors < 2 or neighbors > 3
        state = 0
      elsif neighbors > 1 && neighbors < 4
        state = 1
      end
    else
      if neighbors == 3
        state = 1
      end
    end
    state
  end

  def is_alive?(c, r)
    get_cell(r, c) == 1
  end

end
