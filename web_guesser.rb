require 'sinatra'
require 'sinatra/reloader'

class GuessChecker
  attr_reader :secret_number

  def initialize
    @secret_number = rand(100)
  end

  def check_guess(guess)
    if guess == nil
      "Welcome to my 'Guess the Number' game. Enter a number to start playing!"
    elsif guess.to_i > secret_number + 5
      "Way too high! Guess again."
    elsif guess.to_i > secret_number
      "Too high!"
    elsif guess.to_i < secret_number - 5
      "Way too low! Guess again."
    elsif guess.to_i < secret_number
      "Too low! Guess again."
    else guess.to_i == secret_number
      "You got it right! The SECRET NUMBER is #{secret_number}."
    end
  end

  def background_color(guess)
    if guess.to_i < (secret_number - 5) || guess.to_i > (secret_number + 5)
      color = "red"
    elsif guess.to_i < secret_number || guess.to_i > secret_number
      color = "pink"
    else
      color = "green"
    end
  end

end

gc = GuessChecker.new
get '/' do
  guess = params["guess"]
  erb :index, :locals => {:message => gc.check_guess(guess), :color => gc.background_color(guess)}
end
