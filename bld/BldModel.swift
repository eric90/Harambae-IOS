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

enum Restriction {
    case gluten_free
    case vegetarian
    case vegan
    case pescitarian
    case paleo
    case nut_allergy
    case lactose_intolerant
    case soy_allergy
    case egg_allergy
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

class Ingredient {
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

///////////////////////////////////////////
///////////////////////////////////////////

class Recipe {
    let name: String
    let ingredients: [Ingredient]
    
    init(name: String, ingredients: [Ingredient]) {
        self.name = name
        self.ingredients = ingredients
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
    var prohibitedItems: [Ingredient]?
    var dietaryRestriction: [Restriction]?
}

///////////////////////////////////////////
///////////////////////////////////////////

class Day {
    let date: NSDate
    var breakfast: Recipe?
    var lunch: Recipe?
    var dinner: Recipe?
    
    init(date: NSDate, breakfast: Recipe?, lunch: Recipe?, dinner: Recipe?) {
        self.date = date
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
}

class Calendar {
    var days: [Day]?
}

///////////////////////////////////////////
///////////////////////////////////////////

class DayRequest {
    let date: NSDate
    let breakfast: Bool
    let lunch: Bool
    let dinner: Bool
    
    init(date: NSDate, breakfast: Bool, lunch: Bool, dinner: Bool) {
        self.date = date
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
}

class MealRequest {
    var request: [DayRequest]
    var budget: Float
    
    init(request: [DayRequest], budget: Float) {
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
    var caldendar: Calendar?
    var pantry: Pantry?
    var diet: Diet?
    var request: MealRequest?
    
    func updateCalendar() {
    }
}


