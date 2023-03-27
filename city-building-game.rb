class CityBuilderGame
  def initialize
    @money = 1000
    @population = 10
    @city_name = ""
    @buildings = []
  end

  def start
    puts "Welcome to the City Builder game!"
    puts "What's the name of your city?"
    @city_name = gets.chomp.capitalize
    puts "Your city name is #{@city_name}."
    puts "You have $#{@money} and a population of #{@population} people."
    puts "Let's start building your city!"

    loop do
      display_menu
      action = gets.chomp.downcase
      case action
      when "build"
        build_building
      when "destroy"
        destroy_building
      when "balance"
        display_balance
      when "population"
        display_population
      when "quit"
        puts "Thanks for playing!"
        break
      else
        puts "Invalid action."
      end
    end
  end

  def display_menu
    puts "------------------"
    puts "What do you want to do?"
    puts "1. Build a building"
    puts "2. Destroy a building"
    puts "3. Check balance"
    puts "4. Check population"
    puts "5. Quit"
    puts "------------------"
  end

  def build_building
    puts "What building do you want to build?"
    puts "1. House ($100, +1 population)"
    puts "2. Factory ($500, +$50/day)"
    choice = gets.chomp.to_i
    case choice
    when 1
      if @money >= 100
        @money -= 100
        @population += 1
        @buildings << "House"
        puts "You built a house! Your population is now #{@population}."
      else
        puts "You don't have enough money to build a house."
      end
    when 2
      if @money >= 500
        @money -= 500
        @buildings << "Factory"
        puts "You built a factory!"
      else
        puts "You don't have enough money to build a factory."
      end
    else
      puts "Invalid choice."
    end
  end

  def destroy_building
    puts "What building do you want to destroy?"
    @buildings.each_with_index { |building, index| puts "#{index+1}. #{building}" }
    choice = gets.chomp.to_i
    if choice.between?(1, @buildings.length)
      building = @buildings[choice-1]
      case building
      when "House"
        @population -= 1
        puts "You destroyed a house! Your population is now #{@population}."
      when "Factory"
        puts "You destroyed a factory."
      end
      @buildings.delete_at(choice-1)
    else
      puts "Invalid choice."
    end
  end

  def display_balance
    puts "Your balance is $#{@money}."
  end

  def display_population
    puts "Your population is #{@population}."
  end
end

game = CityBuilderGame.new
game.start
