require 'benchmark'

describe Sudoku::Board do
  # This is nasty, but alas time
  let(:sample_board) { described_class.new(puzzles.first) }

  it 'should store a board' do
    expect(sample_board.board).to be_a Array
  end

  context 'the stored board' do
    it "should not contain #{described_class::EMPTY_SPACE} characters" do
      sample_board.board.each do |row|
        expect(row.select { |value| value == described_class::EMPTY_SPACE }).to be_empty
      end
    end

    it 'should only contain integers or nil values' do
      sample_board.board.each do |row|
        expect(row.select { |value| value.is_a? String }).to be_empty
      end
    end
  end

  it 'should retrieve a human-readable board' do
    b = described_class.new(puzzles.first)
    expect(b.to_grid).to eq(simple_board_array)
  end

  describe '.row' do
    it 'returns a single row of the board' do
      b = described_class.new(puzzles.first)
      expect(b.row(0)).to eq(b.board[0])
    end
  end

  describe '.col' do
    it 'returns a single column of the board' do
      b = described_class.new(puzzles.first)
      expect(b.col(0)).to eq(b.board.transpose[0])
    end
  end

  it 'should solve a basic board' do
    sample_board.solve!
    expect(sample_board.board).to eq(simple_solution)
  end

  it 'should solve all of the example puzzles', :slow do
    times = []
    Benchmark.benchmark(Benchmark::CAPTION, 7, Benchmark::FORMAT, '>avg: ') do |bench|
      puzzles.each do |puzzle|
        b = described_class.new(puzzle)
        time = bench.report { b.solve! }
        times << time
      end
    end
    # TODO: This should probably be written to a file or have cleaner output
    # than it does now
    puts "Average: #{times.reduce(:+) / puzzles.size.to_f}"
  end

  #describe '.valid?' do
  #  it 'determines if a value is valid for a board' do
  #    b = described_class.new(puzzles.first)
  #  end
  #end
end
