//
//  CalendarViewController.swift
//  bld
//
//  Created by Benjamin Perez on 12/2/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    
    let lunch1 = Recipe(name: "Chana Masala", ingredients: [], url: "https://orangette.net/2006/03/a-public-display-of-chickpeas/")
    let dinner1 = Recipe(name: "Moroccan Stew", ingredients: [], url: "https://www.theguardian.com/lifeandstyle/2013/jan/19/recipes-under-5-chickpea-stew")
    let dinner2 = Recipe(name: "Chard and Saffron Omlette", ingredients: [], url: "https://www.theguardian.com/lifeandstyle/2007/aug/11/foodanddrink.recipes")
    let breakfast1 = Recipe(name: "Oatmeal", ingredients: [], url: "https://www.theguardian.com/lifeandstyle/wordofmouth/2011/nov/10/how-to-cook-perfect-porridge")
    
    var day1 = Day(date: "Friday")
    var day2 = Day(date: "Sunday")
    
    /////////////////////////////////////////////////
    
    var calendar = Calendar()
    
    var displayDay: Day?
    
    var selectedMeal: Recipe?
    
    /////////////////////////////////////////////////
    ////////////// BUTTON LABELS ////////////////////
    /////////////////////////////////////////////////
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var breakfastButton: UIButton!
    @IBOutlet weak var lunchButton: UIButton!
    @IBOutlet weak var dinnerButton: UIButton!
    
    /////////////////////////////////////////////////
    ////////////// BUTTON ACTIONS ///////////////////
    /////////////////////////////////////////////////
    
    @IBAction func showBreakfast(_ sender: Any) {
        selectedMeal = displayDay?.breakfast
        performSegue(withIdentifier: "showMeal", sender: self)
    }
    
    @IBAction func showLunch(_ sender: Any) {
        selectedMeal = displayDay?.lunch
        performSegue(withIdentifier: "showMeal", sender: self)
    }
    
    @IBAction func showDinner(_ sender: Any) {
        selectedMeal = displayDay?.dinner
        performSegue(withIdentifier: "showMeal", sender: self)
    }
    
    /////////////////////////////////////////////////
    /////////////// ARROW ACTIONS ///////////////////
    /////////////////////////////////////////////////
   
    @IBAction func previousDay(_ sender: Any) {
        calendar.decrementDisplayDate()
        displayDay = calendar.loadDay(dayName: calendar.displayDate)
        loadData()
    }
    
    @IBAction func nextDay(_ sender: Any) {
        calendar.incrementDisplayDate()
        displayDay = calendar.loadDay(dayName: calendar.displayDate)
        loadData()
    }
   
    /////////////////////////////////////////////////
    /////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        breakfastButton.layer.cornerRadius = 15
        lunchButton.layer.cornerRadius = 15
        dinnerButton.layer.cornerRadius = 15
        breakfastButton.clipsToBounds = true
        lunchButton.clipsToBounds = true
        dinnerButton.clipsToBounds = true

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /////////////////////////////////////////////////
    ///////////////// LOAD VC METHOD ////////////////
    /////////////////////////////////////////////////
    
    private func loadData() {
        // GET CALENDAR FROM MAIN TAB BAR CONTROLLER
        let mainController = self.tabBarController  as! MainTabBarViewController
        calendar = mainController.mainData.calendar
        displayDay = calendar.days[calendar.displayDate]
        
        // CHANGE TITLE AND MEAL BUTTON LABELS
        self.title = "Calendar"
        dateLabel.text = displayDay?.date
        breakfastButton.setTitle(displayDay?.breakfast.name, for: .normal)
        lunchButton.setTitle(displayDay?.lunch.name, for: .normal)
        dinnerButton.setTitle(displayDay?.dinner.name, for: .normal)
    }
    
    /////////////////////////////////////////////////
    ///////////////// SEGUE METHODS /////////////////
    /////////////////////////////////////////////////
    
    //SEGUE FOR DISPLAYING MEALS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showMeal") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! MealViewController
            // your new view controller should have property that will store passed value
            viewController.url = selectedMeal?.url
        }
    }
    
    //SEGUE THAT RECEIVES MEAL REQUEST
    @IBAction func processMealRequest(segue:UIStoryboardSegue) {
        day1.lunch = lunch1
        day1.dinner = dinner1
        day2.breakfast = breakfast1
        day2.dinner = dinner2
        
        calendar.days["Friday"] = day1
        calendar.days["Sunday"] = day2
        loadData()
        //if let mealPlannerViewController = segue.source as? MealPlannerViewController {
        //let mealRequest = mealPlannerViewController.mealRequest
        //    print("\(mealRequest)")
        //}
    }
    
    //CANCEL MEAL REQUESTION
    @IBAction func cancelMealRequest(segue:UIStoryboardSegue) {
    }
    
    
    

}
