#!/usr/bin/perl

use strict;
use warnings;

# Define the starting resources
my $money = 1000;
my $population = 100;
my $food = 100;
my $water = 100;

# Define the city's starting buildings
my %buildings = (
    "house" => 10,
    "farm" => 5,
    "well" => 2
);

# Define the game loop
while (1) {
    # Display the current city information
    print "Money: $money\n";
    print "Population: $population\n";
    print "Food: $food\n";
    print "Water: $water\n";
    print "Buildings:\n";
    foreach my $building (keys %buildings) {
        print "  $building: $buildings{$building}\n";
    }

    # Prompt the player to choose an action
    print "Choose an action (build/buy/sell/exit): ";
    my $action = lc(<STDIN>);
    chomp($action);

    # Handle the player's action
    if ($action eq "build") {
        # Prompt the player to choose a building to construct
        print "Choose a building to construct (house/farm/well): ";
        my $building = lc(<STDIN>);
        chomp($building);

        # Check if the player has enough money to construct the building
        my $cost;
        if ($building eq "house") {
            $cost = 100;
        } elsif ($building eq "farm") {
            $cost = 200;
        } elsif ($building eq "well") {
            $cost = 50;
        } else {
            print "Invalid building type. Please choose house, farm, or well.\n";
            next;
        }
        if ($money < $cost) {
            print "You don't have enough money to construct that building.\n";
            next;
        }

        # Construct the building and deduct the cost from the player's money
        $buildings{$building}++;
        $money -= $cost;

        # Update the population, food, and water based on the new building
        if ($building eq "house") {
            $population += 10;
        } elsif ($building eq "farm") {
            $food += 50;
        } elsif ($building eq "well") {
            $water += 50;
        }
    } elsif ($action eq "buy") {
        # Prompt the player to choose a resource to buy
        print "Choose a resource to buy (food/water): ";
        my $resource = lc(<STDIN>);
        chomp($resource);

        # Check if the player has enough money to buy the resource
        my $cost;
        if ($resource eq "food") {
            $cost = 10;
        } elsif ($resource eq "water") {
            $cost = 5;
        } else {
            print "Invalid resource type. Please choose food or water.\n";
            next;
        }
        if ($money < $cost) {
            print "You don't have enough money to buy that resource.\n";
            next;
        }

        # Buy the resource and deduct the cost from the player's money
        if ($resource eq "food") {
            $food += 10;
        } elsif ($resource eq "water") {
            $water += 10;
        }
        $money -= $cost;
    } elsif ($action eq "sell") {
        # Prompt the player to choose a resource to sell
        print "Choose a resource to sell (food/water): ";
        my $resource = lc(<STDIN>);
        chomp($resource);

        # Check if the player has enough of the selected resource to sell
        my $amount;
        if ($resource eq "food") {
            $amount = $food;
        } elsif ($resource eq "water") {
            $amount = $water;
        } else {
            print "Invalid resource type. Please choose food or water.\n";
            next;
        }
        if ($amount == 0) {
            print "You don't have any $resource to sell.\n";
            next;
        }

        # Sell the resource and add the sale amount to the player's money
        if ($resource eq "food") {
            $food -= 10;
        } elsif ($resource eq "water") {
            $water -= 10;
        }
        $money += 5;
    } elsif ($action eq "exit") {
        # Exit the game loop
        last;
    } else {
        # Invalid action, prompt the player to try again
        print "Invalid action. Please choose build, buy, sell, or exit.\n";
    }
}

# Game over
print "Game over. Thanks for playing!\n";
