class Computer

  require_relative 'compare_module.rb'
  include Compare

  attr_accessor :code
  attr_reader :colors

  def initialize
    @colors = ["red","orange", "green", "blue", "magenta", "cyan"]
    @code = []
  end

  def generate_code
    4.times do
      @code << @colors.sample
    end
    @code
  end
  
  def guess_code(player_code, code)
    indicator = 0
      count = compare(code, player_code)
      if count[0] == 4
        indicator = 1
      elsif count[1] == 4
        indicator = 2
      elsif count[1] < 4
        indicator = 3
      elsif count[0] < 4
        indicator = 4
      end
      indicator
   end
end



