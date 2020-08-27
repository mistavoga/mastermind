module Compare

  def compare(chiffre, guess)
    count = 0
    sec_count = 0
    chiffre.each_with_index do |i, j|
      if chiffre[j] == guess[j]
        count += 1
      elsif guess.any?(chiffre[j]) && chiffre[j] != guess[j]
       sec_count += 1
      end
    end
    return count, sec_count
  end
  
end
