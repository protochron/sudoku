module Puzzles
  def puzzles
    @@puzzles ||= load_puzzles
  end


  def simple_board
    puzzles.first
  end

  def simple_solution
    [[4, 8, 3, 9, 2, 1, 6, 5, 7], [9, 6, 7, 3, 4, 5, 8, 2, 1], [2, 5, 1, 8, 7, 6, 4, 9, 3], [5, 4, 8, 1, 3, 2, 9, 7, 6], [7, 2, 9, 5, 6, 4, 1, 3, 8], [1, 3, 6, 7, 9, 8, 2, 4, 5], [3, 7, 2, 6, 8, 9, 5, 1, 4], [8, 1, 4, 2, 5, 3, 7, 6, 9], [6, 9, 5, 4, 1, 7, 3, 8, 2]]
  end

  def simple_board_array
    [
       "-,-,3,-,2,-,6,-,-\n",
       "9,-,-,3,-,5,-,-,1\n",
       "-,-,1,8,-,6,4,-,-\n",
       "-,-,8,1,-,2,9,-,-\n",
       "7,-,-,-,-,-,-,-,8\n",
       "-,-,6,7,-,8,2,-,-\n",
       "-,-,2,6,-,9,5,-,-\n",
       "8,-,-,2,-,3,-,-,9\n",
       "-,-,5,-,1,-,3,-,-\n"
    ]
  end

  private

  def load_puzzles
    puzzle_file = File.expand_path('../../fixtures/easy50.txt', __FILE__)
    puzzles_input = File.readlines(puzzle_file)
    puzzles = []
    sub_puzzle = []
    puzzles_input.each do |ln|
      if ln[0] == '='
        puzzles << sub_puzzle
        sub_puzzle = []
      else
        ln = ln.gsub('0', '-')
        sub_puzzle << ln.strip.split('').join(',')
      end
    end
    puzzles
  end
end
