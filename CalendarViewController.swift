//
//  CalendarViewController.swift
//  bld
//
//  Created by Benjamin Perez on 12/2/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

let newRegularCalendar = Calendar()
let regularSat = Day(date: "Saturday")
// BEN ADD THESE 3 LINES
//regularSat.breakfast = Recipe(name: "Shredded Kale and Brussels Sprout Salad with Lemon Dressing", ingredients: [])
//regularSat.lunch = Recipe(name: "Cabbage Salad with Peanuts", ingredients: [])
//newRegularCalendar.days["Saturday"] = regularSat







//let regularSun = Day(date: "Sunday")
//regularSun.dinner = none
//newRegularCalendar.days["Sunday"] = regularSun


//let newVeggieCalendar = Calendar()
//let veggieSat = Day(date: "Saturday")
//veggieSat.breakfast = none
//veggieSat.lunch = none
//newVeggieCalendar.days["Saturday"] = veggieSat
//let veggieSun = Day(date: "Sunday")
//veggieSun.dinner = none
//newVeggieCalendar.days["Sunday"] = veggieSun

class CalendarViewController: UIViewController {
    
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
            viewController.recipe = selectedMeal
        }
    }
    
    //SEGUE THAT RECEIVES MEAL REQUEST
    @IBAction func processMealRequest(segue:UIStoryboardSegue) {
        if let mealPlannerViewController = segue.source as? MealPlannerViewController {
            let mealRequest = mealPlannerViewController.mealRequest
            //insert plan method... mod calendar variable
            //reload the calendar/page
            print("\(mealRequest)")
        }
    }
    
    //CANCEL MEAL REQUESTION
    @IBAction func cancelMealRequest(segue:UIStoryboardSegue) {
    }
    
    
    

}
