//
//  classes.swift
//  bld_model
//
//  Created by Benjamin Perez on 11/15/16.
//
//

import Foundation

//////////////////////////////////////////////////////////////////
//////////////////// UNITS AND FOOD TYPES ////////////////////////
//////////////////////////////////////////////////////////////////

enum FoodType: String {
    case Dairy, Produce, Meat, Grains, Canned, Beverages, Snacks
    static var allTypes = ["Dairy","Produce","Meat","Grains","Canned","Beverages","Snacks"]
}

///////////////////////////////////////////
///////////////////////////////////////////

enum Unit: String {
    case oz, lb, cup, tbsp, tsp
    static var allUnits = ["oz","lb","cup","tbsp","tsp"]
}

///////////////////////////////////////////
///////////////////////////////////////////

enum Restriction: String {
    case vegetarian, vegan, pescitarian, paleo
    static var allRestrictions = ["vegetarian","vegan","pescitarian","paleo"]
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

class Ingredient: Equatable {
    let name: String
    let type: FoodType
    var amount: Float
    let unit: Unit
    
    init(name: String, type: FoodType, amount: Float, unit: Unit) {
        self.name = name
        self.type = type
        self.amount = amount
        self.unit = unit
    }
    
    func createJSON() -> String {
        return "Hey! This is a function to make!"
    }
    
    
}

//extension Ingredient: Equatable {}
//
func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
    return lhs.name == rhs.name && lhs.amount == rhs.amount && lhs.type == rhs.type && lhs.unit == rhs.unit
}

///////////////////////////////////////////
///////////////////////////////////////////

class Recipe {
    let name: String
    let ingredients: [Ingredient]
    var _cost : Double?
    var _calories : Double?
    
    init(name: String, ingredients: [Ingredient]) {
        self.name = name
        self.ingredients = ingredients
    }
    
    func usedIngreds() -> [Ingredient] {
        return self.ingredients
    }
    
    func cost() -> Double {
        if (self._cost == nil) {
            self._cost = ingredients.map(getCostOfIngred).reduce(0.0, +)
        }
        return self._cost!
    }
    
    func calories() -> Double {
        if (self._calories == nil) {
            self._calories = ingredients.map(getCostOfIngred).reduce(0.0, +)
        }
        return self._cost!
    }
}

class CookBook {
    var recipes: [Recipe]?
}

class Pantry {
    var ingredients: [FoodType: [Ingredient]]
    
    init() {
        ingredients = [FoodType: [Ingredient]]()
        for foodType in FoodType.allTypes {
            let type = FoodType(rawValue: foodType)
            ingredients[type!] = []
        }
    }
    
    func createJSON() -> String {
        return "Another function 4 u"
    }
}

class Diet {
    var prohibitedItems: [Ingredient]
    var dietaryRestriction: [Restriction]
    
    init() {
        prohibitedItems = []
        dietaryRestriction = []
    }
}

///////////////////////////////////////////
///////////////////////////////////////////

class Day {
    let date: String
    var breakfast: Recipe
    var lunch: Recipe
    var dinner: Recipe
    
    init(date: String) {
        self.date = date
        self.breakfast = none
        self.lunch = none
        self.dinner = none
    }

    let none = Recipe(name: "None", ingredients: [])
}

class Calendar {
    var days: [String: Day]
    var displayDate: String
    
    let weekDays = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    /////////////////////
    /////////////////////
    
    init() {
        let currentDate = "Friday"
        days = [currentDate: Day(date: currentDate)]
        displayDate = currentDate
    }
    
    /////////////////////
    /////////////////////
    
    func loadDay(dayName: String) -> Day {
        if let day = days[dayName] {
            return day
        } else {
            days[dayName] = Day(date: dayName)
            return days[dayName]!
        }
    }
    
    func incrementDisplayDate() {
        let addDateIndex = ((weekDays.index(of: displayDate))! + 1) % 7
        displayDate = weekDays[addDateIndex]
    }
    
    func decrementDisplayDate() {
        let subtractDateIndex = ((weekDays.index(of: displayDate))! - 1) % 7
        displayDate = weekDays[subtractDateIndex]
    }
    
}

///////////////////////////////////////////
///////////////////////////////////////////

class DayRequest {
    let date: String
    var breakfast: Bool
    var lunch: Bool
    var dinner: Bool
    
    init(date: String, breakfast: Bool, lunch: Bool, dinner: Bool) {
        self.date = date
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
}

class MealRequest {
    var request: [DayRequest]
    var budget: Double
    
    init(request: [DayRequest], budget: Double) {
        self.request = request
        self.budget = budget
    }
    
    func createJSON() -> String {
        return "You lovve making methods <3<3<3"
    }
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

class BLD {
    var calendar: Calendar
    var pantry: Pantry
    var diet: Diet
    var request: MealRequest?
    
    init() {
        calendar = Calendar()
        pantry = Pantry()
        diet = Diet()
    }
    
    func updateCalendar() {
    }
}


