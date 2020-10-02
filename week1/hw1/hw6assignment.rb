# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
    # The constant All_My_Pieces should be declared here
    All_My_Pieces = 
    [
      [[[0, 0], [-1, 0], [1, 0], [2, 0],[-2,0]], # 5-long (only needs two)
                 [[0, 0], [0, -1], [0, 1], [0, 2],[0,-2]]],
                 rotations([[0, 0], [1, 0], [-1, 0], [0, 1],[1,1]]),  # square+one (only needs one)
                 rotations([[0, 0], [1, 0], [0, 1]]),
                 [[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
                 rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
                 [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
                 [[0, 0], [0, -1], [0, 1], [0, 2]]],
                 rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
                 rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
                 rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
                 rotations([[0, 0], [1, 0], [0, -1], [-1, -1]])
    ] 
  
   
    # your enhancements here
    def self.next_piece (board)
      MyPiece.new(All_My_Pieces.sample, board)
    end
    def self.cheat_piece (board)
      MyPiece.new([[[0,0]]], board)
    end
  end
  
  class MyBoard < Board
    # your enhancements here
    def initialize(game)
    super
    @current_block = MyPiece.next_piece(self)
    @cheating = false
         
    end
    # gets the next piece
    def next_piece
      if @cheating
         @current_block = MyPiece.cheat_piece(self)
         @cheating = false
      else
         @current_block = MyPiece.next_piece(self)
      end
      @current_pos = nil
    end
  
  
  
    def store_current
      locations = @current_block.current_rotation
      displacement = @current_block.position
      block_count = locations.size
      (0..block_count-1).each{|index| 
        current = locations[index];
        @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
        @current_pos[index]
      }
      remove_filled
      @delay = [@delay - 2, 80].max
    end
  
  
  
  
    def cheat
      if @score >= 100 && (!@cheating)
        @cheating = true
        @score -= 100
      end
      draw
    end
  
  
  end
  
  class MyTetris < Tetris
    # your enhancements here
    
    def key_bindings
  
    super
    @root.bind('u', proc {@board.rotate_clockwise;@board.rotate_clockwise})
    
    @root.bind('c', proc {@board.cheat})
    
  
    end
    def set_board
      @canvas = TetrisCanvas.new
      @board = MyBoard.new(self)
      @canvas.place(@board.block_size * @board.num_rows + 3,
                    @board.block_size * @board.num_columns + 6, 24, 80)
      @board.draw
    end
  
  
  
  end
  
  