require 'sinatra'
require 'sinatra/reloader'

class GuessChecker
  attr_reader :number

  def initialize
    @number = rand(100)
  end

  def check_guess(guess)
    if guess == nil
      "Enter a number!"
    elsif guess.to_i > number + 5
      "Way too high!"
    elsif guess.to_i > number
      "Too high!"
    elsif guess.to_i < number - 5
      "Way too low!"
    elsif guess.to_i < number
      "Too low!"
    else guess.to_i == number
      "You got it right! The SECRET NUMBER is #{number}"
    end
  end

end

gc = GuessChecker.new
get '/' do
  guess = params["guess"]
  erb :index, :locals => {:message => gc.check_guess(guess)}
end
