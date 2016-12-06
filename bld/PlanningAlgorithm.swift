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

//      targetMealBudget <- budgetMeal(thisDayBudget, neededMeal, budgetPerSlot, remainingIngreds)
//      targetMealCalories <- mealCalories(thisDayCalories, neededMeal)

//      candidateRecipes <-
//         getCandidates(type(neededMeal), diet)
//         .sortBy(errorMetric(targetMealBudget, targetMealCalories))

//      choice = candidateRecipes.first
//
//      suggestedRecipes.meal.neededMeal <- choice
//      remainingIngreds <- remainingIngreds -- usedIngreds(choice)
//      thisDayBudget <- thisDayBudget - cost(choice)
//      thisDayCalories <- thisDayCalories - calories(choice)



