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
let foodURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/products/classify"

// send a request to the spoonacular service

func tester () {
    let url = URL(string: foodURL)
    
    
    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
        guard error == nil else {
            print(error!)
            return
        }
        guard let data = data else {
            print("Data is empty")
            return
        }
        
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        print(json)
    }
    
    task.resume()
    
}


//func spoonResponse(res: URLResponse!, data: NSData!, error: NSError!) {
//    
//    let json: NSDictionary = JSONSerialization.JSONObjectWithData(data, options:  JSONSerialization.ReadingOptions.allowFragments) as NSDictionary
//    let header: NSDictionary = ["X-Mashape-Key" : "jY0bEhHCBpmsh8j1mpA5p11tCJGyp1tok3Zjsn4ubbvNNp5Jt3"]
//    
//    for value in json {
//        println(value)
//    }
//}

