require 'pry'

class BoardCase
  #TO DO : la classe a 2 attr_accessor, sa valeur (X, O, ou vide), ainsi que son numéro de case)
  attr_accessor :value
  
  def initialize (value)
    #TO DO doit régler sa valeur, ainsi que son numéro de case
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
  puts "\n #{game_board_values[0]} | #{game_board_values[1]} | #{game_board_values[2]}"
  puts "\n---|---|---"
  puts "\n #{game_board_values[3]} | #{game_board_values[4]} | #{game_board_values[5]}"
  puts "\n---|---|---"
  puts "\n #{game_board_values[6]} | #{game_board_values[7]} | #{game_board_values[8]}" 
  end

  #update the board with new input at each turn
  def update_board (location, symbol)
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
    cell_number << @cell_chosen 
 end
end

# ----------------------------------------------------------------------------------------------------
class Game 
  attr_accessor :player1, :player2, :board, :current_player

  def initialize 
    @player1 = player1 
    @player2 = player2 
    @board = Board.new()
    @current_player = @player1
  end

  # 
 #introduit le premier joueur
    puts "What is the name of the first player ?"
    player1_name = gets.chomp
    @player1 = Player.new(player1_name, "X")


    puts "What is the name of the second player ?"
    player2_name = gets.chomp
    @player2 = Player.new(player2_name, "O")


  def display_board
    puts "How to play ?"
    puts "Pick a number to start and play"
    puts ' '
    puts @board.game_board(@board.legend_value)
    puts ' '
    puts "Let's start !"
    puts @board.game_board(@board.board_values)
    puts ' '
  end
end