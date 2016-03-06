# frozen_string_literal: true
require 'csv'

module Sudoku
  # Object representing a board and it's state
  class Board
    # The empty space character we read in
    EMPTY_SPACE = '-'.freeze
    # The size of the sudoku board
    SIZE = 9
    # The set of legal values for a sudoku board
    VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze

    attr_reader :board
    def initialize(board)
      parsed_board = board.reduce([]) do |acc, row|
        parsed_row = row.parse_csv
        parsed_row.map! { |i| i == EMPTY_SPACE ? nil : i.to_i }
        acc << parsed_row
      end
      @board = parsed_board
    end

    # Get the size of the board
    # @return [Integer]
    def size
      @board.size
    end

    # Get the specified row of a board
    #
    # @param [Integer] index the index of the row
    # @return Array the row from the board
    def row(index)
      @board[index]
    end

    # Get the specified column of a board
    #
    # @param [Integer] index the index of the column
    def col(index)
      @board.transpose[index]
    end

    # Attempt to replace the empty board with a solution starting from the first cell
    def solve!
      solve_position(0, 0)
    end

    # Recursive backtrack to solve the sudoku puzzle
    #
    # This should examine every cell to determine if the value at that cell is part of a valid sudoku solution
    #
    # There are a few different cases:
    #   1) The cell already has a value
    #   2) The cell needs to be provided with a value
    #
    # In the first case, we simply leave the existing value alone and move on to the next value
    #
    # In the second, we attempt to find a value that is legal at (row, col) according to the rules in {#valid?}. It will go through and iterate over every possible value at that cell until it finds a valid solution and can move on. If one does not exist then it unsets the value and backtracks to a previously unsolved state
    #
    # @param [Integer] row the row to examine
    # @param [Integer] col the column to examine
    # @return [Boolean]
    def solve_position(row, col)
      return true if row == SIZE

      # If we already have a value here then don't change it
      if @board[row][col]
        if col == (SIZE - 1)
          return true if solve_position(row + 1, 0)
        elsif solve_position(row, col + 1)
          return true
        end

        # Backtrack at this point
        return false
      end

      # If we have an empty value, then try and fill it in and see what happens
      VALUES.each do |candidate|
        next unless valid?(row, col, candidate)
        @board[row][col] = candidate
        if col == (SIZE - 1)
          return true if solve_position(row + 1, 0)
        elsif solve_position(row, col + 1)
          return true
        end
        @board[row][col] = nil
      end

      # If we reach this point then we didn't find a correct value and need to
      # backtrack
      false
    end

    # Determine if a value at a (board_row, board_col) position is legal according to the sudoku rules
    #
    # @param [Integer] row_index the row index
    # @param [Integer] column_index the column index
    # @param [Integer] value the value at this position
    def valid?(row_index, column_index, value)
      # Check the row and column to see if the value is already there
      if row(row_index).include?(value) || col(column_index).include?(value)
        return false
      end

      valid_in_square?(row_index, column_index, value)
    end

    # Check if a value is valid within a 3x3 square
    #
    # This is only intended to check the 4 cells adjacent to the value that are *not* covered by simply examining values in the same row or column
    def valid_in_square?(row_index, column_index, value)
      # Top row of the square
      square_row = 3 * (row_index / 3)
      # Starting column of the square
      square_col = 3 * (column_index / 3)

      # Get the indices for the 4 open positions in the square
      # (ignoring values in the row+column the value is in)
      row_index_1 = (row_index + 2) % 3
      row_index_2 = (row_index + 4) % 3
      col_index_1 = (column_index + 2) % 3
      col_index_2 = (column_index + 4) % 3

      # Check the 4 open positions
      return false if @board[square_row + row_index_1][square_col + col_index_1] == value
      return false if @board[square_row + row_index_2][square_col + col_index_1] == value
      return false if @board[square_row + row_index_1][square_col + col_index_2] == value
      return false if @board[square_row + row_index_2][square_col + col_index_2] == value
      true
    end

    # Get a human-readable grid for the board
    # @return [Array] the grid
    def to_grid
      @board.reduce([]) do |acc, row|
        row = row.map { |i| i.nil? ? EMPTY_SPACE : i.to_s }
        acc << row.to_csv
      end
    end
  end
end
