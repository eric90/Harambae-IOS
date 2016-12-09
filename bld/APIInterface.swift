//
//  APIInterface.swift
//  bld
//
//  Created by John Sarracino on 12/3/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import Foundation


// given a MealRequest, Pantry, and Calendar, edit the Calendar or return a new Calendar TODO to
// accomodate the Request by calling the API


// key for API calls
let APIKey = "Ad2o5zmDRjmsh0gznsfNesuUVjLbp1yEKanjsnD6GtWC9k9xSX"
let foodURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/"


func getProductsForIngred(ingred:Ingredient) -> [Int] {
    if let products = getRecipeJSONs(ingredients: [ingred])?["products"] as? [[String: Any]] {
        return products.map{return $0["id"] as! Int}
    } else {
        return []
    }
}

// assumes spoon ID is set
func getCostOfIngred(ingred: Ingredient) -> Double {
    let prods = getProductsForIngred(ingred: ingred)
    var prce = 5.0
    for id in prods {
        let reqSuffix = "food/products/" + String(id)
        let result = synchronousReqJSON(urlSuffix: reqSuffix, getOrPost: true, args: [String: String]())
        if LOGGING {
            print(result)
            print(result["price"]!)
        }
        
        if let resPrice = result["price"] as? Double {
            prce = resPrice
            break;
        }
    }
    
    return Double(prce)/100.0
}
func getCaloriesOfIngred(ingred: Ingredient) -> Double {
    
    return 0.0
}


let LOGGING = false
// send a synchronous get/post http request, along with some args. returns the JSON result.
func synchronousReqJSON(urlSuffix: String, getOrPost: Bool, args: [String: String]) -> [String: Any] {
    var reqURL = foodURL + urlSuffix + "?"
    for (param, v) in args {
        reqURL += ("&" + param + "=" + v)
    }
    
    
    var req = URLRequest(url: URL(string: reqURL)!)
    req.setValue(APIKey, forHTTPHeaderField: "X-Mashape-Key")
    req.httpMethod = getOrPost ? "GET" : "POST"

    // default request is asynchronous so manually synchronize with a semaphore
    let sem = DispatchSemaphore(value: 0)
    var json: [String: Any]?
    
    if LOGGING {
        print("sending:")
        print(req)
    }
    
    let task = URLSession.shared.dataTask(with: req) { data, response, error in
        //        print("responded!")
        // if the api returns an error, or the response is empty, print the error and signal the handler
        guard error == nil else {
            print(error!)
            sem.signal()
            return
        }
        guard let data = data else {
            print("Data is empty")
            sem.signal()
            return
        }
        
        
        // otherwise, convert the response to a json object and signal the handler
        json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        sem.signal()
    }
    
    // fire the asynchronous task
    task.resume()
    
    // response handler: if json is uninitialized, then the api responded with an error
    // TODO: replace empty list with empty JSON
    switch sem.wait(timeout: DispatchTime.distantFuture) {
    case .success:
        if LOGGING {
            print("response:")
            print(json)
        }
        guard json != nil else {
            return [String: Any]()
        }
        
        return json!
    case .timedOut:
        print("timeout on api call with timeout of:")
        print(DispatchTime.distantFuture)
        return [String: Any]()
    }
}

// synchronous recipe request to the spoonacular service
// arguments: ingredients, a list of Ingredients
// returns: a JSON of the response
// TODO: for ease of testing, the argument is hardcoded. replace with commented out code.
func getRecipeJSONs (ingredients: [Ingredient]) -> [String: Any]? {
    
    // build request URL
    var req = URLRequest(url: URL(string: foodURL + "food/ingredients/map")!)
    req.setValue(APIKey, forHTTPHeaderField: "X-Mashape-Key")
    req.httpMethod = "POST"
    // API expects a JSON of the form {"ingredients": ["name"], "servings": numberOfServings}
    
    // TODO: replace with commented out code
    let ingredNames = ingredients.map { (ingred) -> String in
        ingred.name
    }
    
    if LOGGING {
        print("sending:")
        print(req)
    }
    
    let dater: [String:Any] = ["ingredients":ingredNames,"servings":1]
    try! req.httpBody = JSONSerialization.data(withJSONObject: dater, options: .prettyPrinted)
    
    
    // default request is asynchronous so manually synchronize with a semaphore
    let sem = DispatchSemaphore(value: 0)
    var json: [[String: Any]]?
  
    
    let task = URLSession.shared.dataTask(with: req) { data, response, error in
        if LOGGING {
            print("responded!")
        }
        // if the api returns an error, or the response is empty, print the error and signal the handler
        guard error == nil else {
            print(error!)
            sem.signal()
            return
        }
        guard let data = data else {
            print("Data is empty")
            sem.signal()
            return
        }
        if let jsonResp = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if LOGGING {
                print(jsonResp)
            }
        }
        // otherwise, convert the response to a json object and signal the handler
        json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
        sem.signal()
    }
    
    // fire the asynchronous task
    task.resume()
    
    // response handler: if json is uninitialized, then the api responded with an error
    // TODO: replace empty list with empty JSON
    switch sem.wait(timeout: DispatchTime.distantFuture) {
    case .success:
        if LOGGING {
            print("response:")
            print(json)
        }
        guard json != nil else {
            return [String:Any]()
        }
        return json!.first
    case .timedOut:
        print("timeout on api call with timeout of:")
        print(DispatchTime.distantFuture)
        return [String:Any]()
    }
    
}

