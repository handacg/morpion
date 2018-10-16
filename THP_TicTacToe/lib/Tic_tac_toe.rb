require 'pastel'
$pastel = Pastel.new

class BoardCase
  attr_accessor :value
  
  def initialize (value)
    @value = value
  end
  
end

# ----------------------------------------------------------------------------------------------------

class Board
  attr_reader :legend_values, :board_values
  
  # Define intial values for legend board and game board 
  def initialize
  @legend_values = ["1","2","3","4","5","6",'7',"8","9"]
  @board_values = Array.new(9, " ")
  end

  # display the game board
  def game_board (game_board_values)
  puts "\t #{game_board_values[0]} | #{game_board_values[1]} | #{game_board_values[2]}"
  puts "\t---|---|---"
  puts "\t #{game_board_values[3]} | #{game_board_values[4]} | #{game_board_values[5]}"
  puts "\t---|---|---"
  puts "\t #{game_board_values[6]} | #{game_board_values[7]} | #{game_board_values[8]}" 
  end

  #update the board with new input at each turn
  def update_board (symbol,location)
    @board_values [location - 1] = symbol
  end
end

# ----------------------------------------------------------------------------------------------------

class Player
  #TO DO : la classe a 2 attr_accessor, son nom, sa valeur (X ou O). Elle a un attr_writer : il a gagné ?
  attr_accessor :name, :symbol, :cell_chosen
  
  def initialize (name, symbol)
    # cell_chosen will register all choices by the player in an array and match with victory combination (if any)
    @name = name
    @symbol = symbol
    @cell_chosen = []
  end

  def add_cell (cell_number)
    @cell_chosen.push(cell_number)
 end
end

# ----------------------------------------------------------------------------------------------------
class Game 
  attr_accessor :player1, :player2, :board, :current_player

  def initialize 
    @player1 = welcome_player("player1")
    @player2 = welcome_player("player2")
    @board = Board.new()
    @current_player = @player1
  end
 
 # introduce players
   def welcome_player(player)
    player_name = get_name(player)
    player_symbol = get_symbol(player_name)
    Player.new(player_name, player_symbol)
  end

# get name from players
  def get_name(player)
    puts "Welcome, #{player}, what is your name?"
    gets.chomp
  end

# get symbol from players 
  def get_symbol(player_name)
    if @selected_symbol.nil?
      puts "Thanks #{player_name}! What symbol would you like, #{$pastel.yellow('X')} or #{$pastel.red ('O')}?"      
      symbol = gets.chomp.upcase  
# ask again if entry not match with X or O      
      while symbol != "X" && symbol != "O"
        puts "That is not a valid entry, please select #{$pastel.yellow('X')} or #{$pastel.red ('O')}."
        symbol = gets.chomp.upcase
      end
      @selected_symbol = symbol
    else
# Display which symbol is affected to the player       
      symbol = @selected_symbol == "X" ? "O" : "X"
      puts "#{player_name}, your symbol will be '#{symbol}'"
    end
    symbol
  end

  # Display the game board at start
  def display_board
    puts ' '
    puts "--------------READY FOR THIS AWESOME GAME ?--------------"
    puts ' '
    puts "       RULES : pick a number and start to play !"
    puts ' '
    puts @board.game_board(@board.legend_values)
    puts ' '
    puts "Let's start !"
    puts @board.game_board(@board.board_values)
    puts ' '
  end

  # define condition to switch player at each turn
  def switch_player
    if @current_player == @player1
  @current_player = @player2
    else
  @current_player = @player1
    end
  end 


  #
  def cell_update
    location = turn()
    board.update_board(current_player.symbol, location) 
    current_player.add_cell(location)
  end

  #define conditions for each turn
  def turn
    puts "Your turn, #{current_player.name}! Choose an available cell :"
    location = gets.chomp.to_i
    until location.between?(1, 9) && @board.board_values[location - 1] == " "

      unless location.between?(1, 9)
        puts "You need to select a value from 1 to 9. Please select again:"
        location = gets.chomp.to_i
      end
      unless @board.board_values[location - 1] == " "
        puts "This location has already been selected. Try again:"
        location = gets.chomp.to_i
      end
    end
    location
  end

  # define victory or draw game
  def over?
    win_conditions = [[1,2,3], [4,5,6], [7,8,9],[1,4,7],[2,5,8], [3,6,9],[1,5,9], [3,5,7]]
  
  # if current player path matches one of the win_conditions, return victory
    win_conditions.each do |condition|
      if (condition - current_player.cell_chosen).empty?
        puts "#{current_player.name} wins! Another party is on its way !"
        return true
      end
    end  
  # if no cell left, tie game 
    if board.board_values.none? { |value| value == " " }
      puts "Sorry, tie gamer! Another party is on its way !"
      return true
    end
    false
  end
end

loop do   
  game = Game.new()
  game.switch_player
  game.display_board
   until game.over?
    game.switch_player
    game.cell_update
    game.display_board
  end
end
 

