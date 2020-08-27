# coding: utf-8
class Game

  require_relative 'compare_module.rb'
  include Compare
  
  require 'colorize'

  require_relative 'board.rb'
  require_relative 'computer.rb'
  require_relative 'player.rb'
  
  def initialize
    @board = Board.new
    @computer = Computer.new
    @player = Player.new
    @available_colors = {"1" => "red" ,"2" => "orange","3" => "green","4" => "blue","5" => "magenta", "6" => "cyan"}
  end

  def intro
   puts "Welcome to MAsterMInd - The goal is to guess the right combination of 4 colors the computer has chosen. You have 12 attempts and on each turn the computer gives you a feedback whether you have chosen the right color on the right position and if you have chosen the right color but on the wrong position. Alternatively you can choose a combination of colors and the computer will try du evaluate to the right answer."
  end

  def choose_colors
    4.times {set_color}
  end

  def set_color
      puts "Which colors do you want to choose? 1: #{"red".red}, 2: #{"orange".yellow}, 3: #{"green".green}, 4: #{"blue".light_blue}, 5: #{"magenta".magenta}, 6: #{"cyan".cyan}"
      answer = gets.chomp
      if @available_colors.keys.any?(answer)
        @player.chosen_colors << @available_colors[answer]
      else
        puts "This is not a valid number to choose!"
       self.set_color
      end
  end


 def codebreaker
   code = @computer.generate_code
   turn = 0
   while turn < 12
     turn += 1
     choose_colors
     count = compare(code, @player.chosen_colors)
     puts "You've got #{count[0]} colors on the right position and #{count[1]} right colors on the wrong position."
     puts "Your guess was: #{@player.chosen_colors}"
     if count[0] == 4
       puts "Congratulations, you won against the codemaker! You needed #{turn} rounds."
       break
     end
     @player.chosen_colors.clear
     if turn == 12 and count[0] != 4
       puts "Unfortunately you wasn't able to beat the codemaker! Try again!"
       puts "The code was #{code}."
     end
   end
 end

 def codemaker
   res = 3
   choose_colors
   puts "Your code is: #{@player.chosen_colors}."
   turn = 0
   puts "Press Enter to let the computer make a guess."
   while continue = gets.chomp
     turn += 1
     if res > 2
       puts code = @computer.generate_code
       count = compare(code, @player.chosen_colors)
       puts "The computer got #{count[0]} colors on the right position and #{count[1]} on the wrong position."
       puts "Let him try another one."
     elsif res == 2
       puts  code.shuffle
       puts "The computer tries to compose the right combination."
       puts "The computer got #{count[0]} colors on the right position and #{count[1]} on the wrong position."
     else
       puts "The computer has guessed the right combination."
       puts code
       break
     end
     res = @computer.guess_code(@player.chosen_colors, code)
     code.clear if res > 2
     if turn == 12
       puts "The computer wasn't able to guess the right combination."
       break
     end
   end
 end


 def choose_modus
   puts "Which modus do you want to choose? code(b)reaker or code(m)aker? Type b or m:"
   decision = gets.chomp
   if decision == "b"
     codebreaker
   elsif decision == "m"
     codemaker
   else
     puts "This is not a valid modus!"
     self.choose_modus
   end
 end

 def play_round
   intro
   choose_modus
 end  
end

game = Game.new
game.play_round
