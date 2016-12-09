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

protocol fromSpoonJSON {
    associatedtype ME
    static func fromSpoonJSON(r: [String: Any]) -> ME
}

enum FoodType: String {
    case Dairy, Produce, Meat, Grains, Canned, Beverages, Snacks
    static var allTypes = ["Dairy","Produce","Meat","Grains","Canned","Beverages","Snacks"]
}

///////////////////////////////////////////
///////////////////////////////////////////

enum Unit: String {
    case oz, lb, cup, tbsp, tsp, none
    static var allUnits = ["oz","lb","cup","tbsp","tsp", ""]
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

class Ingredient: Equatable, fromSpoonJSON {
    typealias ME = Ingredient

    let name: String
    let type: FoodType?
    var spoonID: Int?
    var amount: Double
    let unit: Unit
    
    init(name: String, type: FoodType?, amount: Double, unit: Unit) {
        self.name = name
        self.type = type
        self.amount = amount
        self.unit = unit
    }
    
    func createJSON() -> String {
        return "Hey! This is a function to make!"
    }
    func setSpoonID(i: Int) {
        self.spoonID = i
    }
    
    internal static func fromSpoonJSON(r: [String: Any]) -> Ingredient {
        let nme = r["name"] as! String
        let typ: FoodType? = nil
        let amt = r["amount"] as! Double
        let unit: Unit
        switch r["unit"] as! String {
            case "cup": unit = Unit.cup
            case "cups": unit = Unit.cup
            case "tablespoons": unit = Unit.tbsp
            case "tablespoon": unit = Unit.tbsp
            case "teaspoon": unit = Unit.tsp
            case "teaspoons": unit = Unit.tsp
            case "pound": unit = Unit.lb
            case "pounds": unit = Unit.lb
            case "": unit = Unit.none
            case _: print("unrecognized case:" + (r["unit"] as! String)); unit = Unit.none
        }
        
        let ret = Ingredient(name: nme, type: typ, amount: amt, unit: unit)
        ret.setSpoonID(i: r["id"] as! Int)
        return ret
    }
}



//extension Ingredient: Equatable {}
//
func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
    return lhs.name == rhs.name && lhs.amount == rhs.amount && lhs.type == rhs.type && lhs.unit == rhs.unit
}

///////////////////////////////////////////
///////////////////////////////////////////

class Recipe: fromSpoonJSON {
    typealias ME = Recipe
    let name: String
    let ingredients: [Ingredient]
    var spoonID: Int?
    var _cost : Double?
    var _calories : Double?
    var _html: String // TODO: set this after meal planning is complete
    
    init(name: String, ingredients: [Ingredient]) {
        self.name = name
        self.ingredients = ingredients
        self._html = ""
    }
    
    func usedIngreds() -> [Ingredient] {
        return self.ingredients
    }

    func setSpoonID(i: Int) {
        self.spoonID = i
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
        return self._calories!
    }
    
    func getHTML() -> String {
        return self._html
    }
    
    internal static func fromSpoonJSON(r: [String : Any]) -> Recipe {
        let ingredJSONs = r["extendedIngredients"] as! [[String: Any]]
        let ingreds = ingredJSONs.map(Ingredient.fromSpoonJSON)
        let ret = Recipe(name: r["title"] as! String, ingredients: ingreds)
        
        let nutrients = (r["nutrition"] as! [String: Any])["nutrients"] as! [[String: Any]]
//        nutrients.first
        let calories = nutrients.filter({return $0["title"] as! String == "Calories"}).first
        ret._calories = calories!["amount"] as! Double
        ret.setSpoonID(i: r["id"] as! Int)
        return ret
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


