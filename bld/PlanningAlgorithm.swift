//
//  PlanningAlgorithm.swift
//  bld
//
//  Created by John Sarracino on 12/6/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import Foundation

// given a MealRequest, Pantry, Calendar, and diet, edit the Calendar or return a new Calendar TODO to
// accomodate the Request.

// find the best candidate per slot, where:
// minimize |delta from cost per slot| + |delta from needed calories| , given range:

// breakfast: 200-400 calories -- 1 calorie count + 1 cost count
// lunch: 400-800 calories -- 2 calorie count
// dinner: 400-800 calories -- 2 calorie count

// so, if a recipe is picked, the needed count is split up proportionally --
// needed count <- needed - taken (float)
// count needed for meal <- remaining / expected for meal

// constraints: total cost <= MealRequest.budget
// calories per day: at least 1500 (5 counts)
// cost per day: 5 counts...don't know cost / count ahead of time. calculate.
// cost per meal = cost of ingreds not present in meal



// enumeration of {breakfast, lunch, dinner}
enum MRDay {
    case breakfast
    case lunch
    case dinner
}

// helper function for slots in meal
// recall:
// breakfast gets one cost portion
// lunch/dinner get 2 cost portions
func slotsInMeal(meal:DayRequest) -> Int {
    var slots = 0
    if (meal.breakfast) {
        slots += 1
    }
    if (meal.lunch) {
        slots += 2
    }
    if (meal.dinner) {
        slots += 2
    }
    return slots
}

// given a meal request, return the cost per slot (as a double) for each desired meal
func costPerMealSlot(request: MealRequest) -> Double {
    return request.budget/Double( sumList(xs: request.request.map(slotsInMeal)) )
}

// TODO
func getCandidateRecipes(mrday: MRDay, diet: Diet) -> [Recipe] {
    return []
}

func errorMetric(recipe: Recipe, targetBudget: Double, targetCalories: Double, remainingIngreds: [Ingredient]) -> Double {
    let calorieError = abs(recipe.calories() - targetCalories)/targetCalories
    let budgetError = abs(recipe.cost() - targetBudget)/targetBudget // TODO
    return calorieError + budgetError
}

// algorithm:

// remainingIngreds <- Pantry.ingreds
// budgetPerSlot <- calculateCostPerSlot(MR)

// suggestedRecipes <- {} # map days to {b/l/d: recipe} plans
// for meal in mealrequest.days that need a meal:
//    suggestedRecipes.meal <- {}
//    thisDayBudget <- calculateBudget(MR.meal)
//    thisDayCalories <- calculateCalories(MR.meal)
//
//    for neededMeal in MR.{breakfast, lunch, dinner}:

//      targetMealBudget <- budgetMeal(thisDayBudget, neededMeal, budgetPerSlot)
//      targetMealCalories <- mealCalories(thisDayCalories, neededMeal)

//      candidateRecipes <-
//         getCandidates(type(neededMeal), diet)
//         .sortBy(errorMetric(targetMealBudget, targetMealCalories, remainingIngreds))

//      choice = candidateRecipes.first
//
//      suggestedRecipes.meal.neededMeal <- choice
//      remainingIngreds <- remainingIngreds -- usedIngreds(choice)
//      thisDayBudget <- thisDayBudget - cost(choice)
//      thisDayCalories <- thisDayCalories - calories(choice)


// find the best candidate per slot, i.e., a map from days to {b/l/d: recipe} plans
// days are strings....
func generatePlan(mr: MealRequest, pan:Pantry, diet: Diet) -> [String: [MRDay: Recipe]] {
    var remainingIngreds = flattenDict(dict: pan.ingredients)
    // TODO: adjust budget as choices are taken
    let budgetPerSlot = costPerMealSlot(request: mr)
    let caloriesPerSlot = 300.0
    
    var suggestedRecipes = [String: [MRDay: Recipe]]()
    
    for meal in mr.request.filter({$0.breakfast || $0.lunch || $0.dinner}) {
        suggestedRecipes[meal.date] = [MRDay: Recipe]()
        let thisMealSlots = slotsInMeal(meal: meal)
        var thisMealBudget = budgetPerSlot * Double(thisMealSlots)
        var thisMealCalories = caloriesPerSlot * Double(thisMealSlots)
        
        // TODO: refactor into function over MRDay
        if (meal.breakfast) {
            let usedSlot = 1
            
            let targetBudget = thisMealBudget - Double(usedSlot) * budgetPerSlot
            let targetCalories = thisMealCalories - Double(usedSlot) * caloriesPerSlot
            
            
            
            let candidates =
                getCandidateRecipes(mrday: MRDay.breakfast, diet: diet)
                //.map({errorMetric(recipe: $0, targetBudget: targetBudget, targetCalories: targetCalories, remainingIngreds: remainingIngreds)})
                .sorted{
                    return errorMetric(recipe: $0, targetBudget: targetBudget, targetCalories: targetCalories, remainingIngreds: remainingIngreds) < errorMetric(recipe: $1, targetBudget: targetBudget, targetCalories: targetCalories, remainingIngreds: remainingIngreds)
                }
        
            if candidates.isEmpty {
                print("empty candidates for breakfast???")
            }
            
            let choice = candidates[0]
            
            suggestedRecipes[meal.date]![MRDay.breakfast] = choice
            remainingIngreds = diff(xs: remainingIngreds, ys: choice.usedIngreds())
            thisMealBudget -= choice.cost()
            thisMealCalories -= choice.calories()
        }
        
        if (meal.lunch) {
            let usedSlot = 2
            
            let targetBudget = thisMealBudget - Double(usedSlot) * budgetPerSlot
            let targetCalories = thisMealCalories - Double(usedSlot) * caloriesPerSlot
            
            
            
            let candidates =
                getCandidateRecipes(mrday: MRDay.lunch, diet: diet)
                    //.map({errorMetric(recipe: $0, targetBudget: targetBudget, targetCalories: targetCalories, remainingIngreds: remainingIngreds)})
                    .sorted{
                        return errorMetric(recipe: $0, targetBudget: targetBudget, targetCalories: targetCalories, remainingIngreds: remainingIngreds) < errorMetric(recipe: $1, targetBudget: targetBudget, targetCalories: targetCalories, remainingIngreds: remainingIngreds)
            }
            
            if candidates.isEmpty {
                print("empty candidates for breakfast???")
            }
            
            let choice = candidates[0]
            
            suggestedRecipes[meal.date]![MRDay.breakfast] = choice
            remainingIngreds = diff(xs: remainingIngreds, ys: choice.usedIngreds())
            thisMealBudget -= choice.cost()
            thisMealCalories -= choice.calories()
        }
        
        if (meal.dinner) {
            let usedSlot = 2
            
            let targetBudget = thisMealBudget - Double(usedSlot) * budgetPerSlot
            let targetCalories = thisMealCalories - Double(usedSlot) * caloriesPerSlot
            
            
            
            let candidates =
                getCandidateRecipes(mrday: MRDay.dinner, diet: diet)
                    //.map({errorMetric(recipe: $0, targetBudget: targetBudget, targetCalories: targetCalories, remainingIngreds: remainingIngreds)})
                    .sorted{
                        return errorMetric(recipe: $0, targetBudget: targetBudget, targetCalories: targetCalories, remainingIngreds: remainingIngreds) < errorMetric(recipe: $1, targetBudget: targetBudget, targetCalories: targetCalories, remainingIngreds: remainingIngreds)
            }
            
            if candidates.isEmpty {
                print("empty candidates for breakfast???")
            }
            
            let choice = candidates[0]
            
            suggestedRecipes[meal.date]![MRDay.breakfast] = choice
            remainingIngreds = diff(xs: remainingIngreds, ys: choice.usedIngreds())
            thisMealBudget -= choice.cost()
            thisMealCalories -= choice.calories()
        }
        
        
    }
    
    
    return suggestedRecipes
}
