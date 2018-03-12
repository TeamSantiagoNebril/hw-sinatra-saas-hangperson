class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(word)
    @guesses = ""
    @wrong_guesses = ""
    @word = word
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess(guess)
    if (guess.nil? || guess.match(/^[[:alpha:]]+$/) == nil)
      raise ArgumentError.new("Error")
    else
      guess.downcase!
      if @word.downcase.include? guess
        if @guesses.downcase.include?(guess) == false
          @guesses = @guesses + guess
          return true
        else
          return false
        end
      else
        if @wrong_guesses.downcase.include?(guess) == false
          @wrong_guesses = @wrong_guesses + guess
        end
        return false
      end
    end
  end

  def word_with_guesses()
    answer = ""
    had_match = false

    @word.each_char do |word_letter|
      @guesses.each_char do |guess_letter|
        if guess_letter == word_letter
          answer = answer + guess_letter
          had_match = true
          break
        end
      end
      answer+= "-" if had_match == false
      had_match = false
    end
    return answer
  end

  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
