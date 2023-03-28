package main

import (
	"fmt"
	"math/rand"
)

// City is a struct that contains information about a city
type City struct {
	Name        string
	Population  int
	Buildings   []Building
	CashBalance int
}

// Building is a struct that contains information about a building
type Building struct {
	Name        string
	Type        string
	Cost        int
	Income      int
	Upkeep      int
	NumUnits    int
	MaxNumUnits int
}

// AddBuilding adds a new building to the city
func (c *City) AddBuilding(b Building) {
	c.Buildings = append(c.Buildings, b)
}

// Simulate simulates the growth and management of the city for a specified number of years
func (c *City) Simulate(years int) {
	for i := 1; i <= years; i++ {
		// Calculate the total income and upkeep for the city
		totalIncome := 0
		totalUpkeep := 0
		for _, b := range c.Buildings {
			totalIncome += b.Income * b.NumUnits
			totalUpkeep += b.Upkeep * b.NumUnits
		}

		// Calculate the net cash flow for the city
		netCashFlow := totalIncome - totalUpkeep

		// Update the city's cash balance
		c.CashBalance += netCashFlow

		// Update the city's population
		c.Population += rand.Intn(1000)

		// Print the city's status
		fmt.Printf("Year %d:\n", i)
		fmt.Printf("Population: %d\n", c.Population)
		fmt.Printf("Cash balance: %d\n", c.CashBalance)
		fmt.Println("Buildings:")
		for _, b := range c.Buildings {
			fmt.Printf("- %s (%s): %d units\n", b.Name, b.Type, b.NumUnits)
		}
		fmt.Println()
	}
}

func main() {
	// Initialize the city
	city := City{
		Name:        "My City",
		Population:  10000,
		CashBalance: 100000,
	}

	// Add some buildings to the city
	city.AddBuilding(Building{Name: "Residential Complex", Type: "Residential", Cost: 100000, Income: 0, Upkeep: 5000, NumUnits: 50, MaxNumUnits: 100})
	city.AddBuilding(Building{Name: "Office Building", Type: "Commercial", Cost: 200000, Income: 10000, Upkeep: 10000, NumUnits: 10, MaxNumUnits: 20})

	// Simulate the city's growth for 10 years
	city.Simulate(10)
}
