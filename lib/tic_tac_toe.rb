require 'pry'

class TicTacToe

attr_accessor :board, :force_quit

def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @force_quit = false

end

WIN_COMBINATIONS = [
    [0,1,2], #TOP ROW
    [3,4,5],  #MIDDLE ROW
    [6,7,8],  #BOTTOM ROW
    [0,3,6],  #1ST COLUMN
    [1,4,7],  #2ND COLUMN
    [2,5,8],  #3RD COLUMN
    [0,4,8],  #L--R DIAGONAL
    [2,4,6]   #R--L DIAGONAL
]

def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    if @board[index] == "X" || @board[index] =="O"
        true
    else
        false
    end
end
   

    def valid_move?(index)
        if position_taken?(index) == false && index >= 0 && index <= 8
            true
        else false
        end
    end

    def turn
        puts "Please input your move:"
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            player_token = current_player
            move(index, player_token)
            display_board
        elsif input == "end"
            @force_quit = true
            over?
        else
            turn
        end
            
    end

    def turn_count
        counter = 0
         @board.each do |i|
            if i == "X" || i == "O"
                counter += 1
        end
    end
        counter
    end

    def current_player
        if turn_count % 2 == 0
            "X"
        else
            "O"
        end
    end

    # def won?
    #     WIN_COMBINATIONS.each do |combo|
            
    #         index_0 = combo[0]
    #         index_1 = combo[1]
    #         index_2 = combo[2]

    #         position_1 = @board[index_0]
    #         position_2 = @board[index_1]
    #         position_3 = @board[index_2]

        

    #         if position_1 == "X" && position_2 == "X"  && position_3 == "X"
    #             combo
    #         elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    #             combo
    #         end
    #     return false
    #     end
    # end

    def won?
        WIN_COMBINATIONS.each {|win_combo|
          index_0 = win_combo[0]
          index_1 = win_combo[1]
          index_2 = win_combo[2]
      
          position_1 = @board[index_0]
          position_2 = @board[index_1]
          position_3 = @board[index_2]
      
          if position_1 == "X" && position_2 == "X" && position_3 == "X"
            return win_combo
          elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
            return win_combo
          end
        }
        return false
    end

    def full?
        @board.all? {|i| i == "X" || i == "O"}
    end

    def draw?
        true if !won? && full?
    end

    def over?
        if draw? || won?
            return true
        elsif @force_quit == true
            return true
        end
    end

    def winner
        index = []
        index = won?
        if index == false
            nil
        else
            if @board[index[0]] == "X" 
                "X"
            else "O"
            end
        end
    end

    def play
        until over? == true
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif force_quit == true
            puts "Goodbye!"
        else
            puts "Cat's Game!"
        end
            
    end

end
