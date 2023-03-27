money <- 1000
population <- 10
city_name <- ""
buildings <- list()

display_menu <- function() {
  cat("------------------\n")
  cat("What do you want to do?\n")
  cat("1. Build a building\n")
  cat("2. Destroy a building\n")
  cat("3. Check balance\n")
  cat("4. Check population\n")
  cat("5. Quit\n")
  cat("------------------\n")
}

build_building <- function() {
  cat("What building do you want to build?\n")
  cat("1. House ($100, +1 population)\n")
  cat("2. Factory ($500, +$50/day)\n")
  choice <- as.numeric(readline())
  switch(choice,
         "1" = {
           if (money >= 100) {
             money <<- money - 100
             population <<- population + 1
             buildings <<- c(buildings, "House")
             cat("You built a house! Your population is now", population, ".\n")
           } else {
             cat("You don't have enough money to build a house.\n")
           }
         },
         "2" = {
           if (money >= 500) {
             money <<- money - 500
             buildings <<- c(buildings, "Factory")
             cat("You built a factory!\n")
           } else {
             cat("You don't have enough money to build a factory.\n")
           }
         },
         cat("Invalid choice.\n"))
}

destroy_building <- function() {
  cat("What building do you want to destroy?\n")
  for (i in seq_along(buildings)) {
    cat(i, ". ", buildings[[i]], "\n")
  }
  choice <- as.numeric(readline())
  if (choice %in% seq_along(buildings)) {
    building <- buildings[[choice]]
    switch(building,
           "House" = {
             population <<- population - 1
             cat("You destroyed a house! Your population is now", population, ".\n")
           },
           "Factory" = {
             cat("You destroyed a factory.\n")
           })
    buildings <<- buildings[-choice]
  } else {
    cat("Invalid choice.\n")
  }
}

display_balance <- function() {
  cat("Your balance is $", money, ".\n")
}

display_population <- function() {
  cat("Your population is ", population, ".\n")
}

start_game <- function() {
  cat("Welcome to the City Builder game!\n")
  cat("What's the name of your city?\n")
  city_name <<- readline()
  cat("Your city name is ", toupper(substr(city_name, 1, 1)), substr(city_name, 2), ".\n")
  cat("You have $", money, " and a population of ", population, " people.\n")
  cat("Let's start building your city!\n")
  repeat {
    display_menu()
    action <- readline()
    switch(tolower(action),
           "build" = {
             build_building()
           },
           "destroy" = {
             destroy_building()
           },
           "balance" = {
             display_balance()
           },
           "population" = {
             display_population()
           },
           "quit" = {
             cat("Thanks for playing!\n")
             break
           },
           cat("Invalid action.\n"))
  }
}

start_game()
