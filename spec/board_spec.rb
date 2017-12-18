$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + "/../app/model")
require 'rubygems'
require 'board'

describe Board do
  let!(:board) { Board.new(5,5)}

  it "should be a 2-D board" do
    expect(board.rows).to eql(5)
    expect(board.cols).to eql(5)
  end

  it 'should be able to get a default value of 0 at a location' do
    expect(board.get_cell(2,4)).to eql(0)
  end
  
  it 'should return nil when the cell is off the grid' do
    expect(board.get_cell(20,4)).to be_nil
  end
  
  it 'should allow setting a cell state' do
    board.set_cell(3, 4, 1)
    expect(board.get_cell(3, 4)).to eql(1)
  end
  
  it 'should allow initializing live cells' do
    starting_array = [[1,2]]
    board.set_board(starting_array)
    expect(board.get_cell(1,2)).to eql(1)
  end
  
  it 'should run a new generation' do
    starting_array = [[1,2]]
    board.set_board(starting_array)
    board.next_gen
    expect(board.get_cell(1,2)).to eql(0)
  end
  
  it 'should get neighbors for a cell' do
    starting_array = [[1,2],[1,3]]
    board.set_board(starting_array)
    expect(board.get_neighbors(1,2)).to eql(1)
  end
  
  it 'should tell if coordinates are in-bounds' do
    expect(board.is_cell(1,2)).to be_truthy
    expect(board.is_cell(1,8)).to be_falsey
  end
  
  it 'should be able to determine if cell dies due to underpopulation Rule 1' do
    starting_array = [[1,2],[1,3]]
    board.set_board(starting_array)
    board.next_gen
    expect(board.get_cell(1,2)).to eql 0
  end

  it 'should be able to determine if cell continues living Rule 2' do
    starting_array = [[1,2],[1,3],[1,1]]
    board.set_board(starting_array)
    board.next_gen
    expect(board.get_cell(1,2)).to eql 1
  end
  
  it 'runs blinker for fun' do
    starting_array = [[1,2],[1,3],[1,1]]
    board.set_board(starting_array)
    (1..20).each do
      break unless board.next_gen
      board.show
      sleep(0.5)
    end
  end
  
  it 'runs random for fun' do
    board = Board.new(20,20)
    starting_array = []
    (1..100).each do
      starting_array << [rand(19), rand(19)]
    end
    board.set_board(starting_array)
    (1..200).each do
      board.show
      sleep(0.1)
      break unless board.next_gen
    end
  end
  
  after :all do
  end
  
end

