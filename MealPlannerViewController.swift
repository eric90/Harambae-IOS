//
//  MealPlannerViewController.swift
//  bld
//
//  Created by Benjamin Perez on 12/3/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class MealPlannerViewController: UIViewController {
    
    var mealRequest = MealRequest(request: [], budget: 0.0)
    
    var days = [
        0: DayRequest(date: "Monday", breakfast: false, lunch: false, dinner: false),
        1: DayRequest(date: "Tuesday", breakfast: false, lunch: false, dinner: false),
        2: DayRequest(date: "Wednesday", breakfast: false, lunch: false, dinner: false),
        3: DayRequest(date: "Thursday", breakfast: false, lunch: false, dinner: false),
        4: DayRequest(date: "Friday", breakfast: false, lunch: false, dinner: false),
        5: DayRequest(date: "Saturday", breakfast: false, lunch: false, dinner: false),
        6: DayRequest(date: "Sunday", breakfast: false, lunch: false, dinner: false)
    ]
    
    
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////

    @IBOutlet weak var budgetTextField: UITextField!
    
    @IBOutlet weak var mondayBreakfastButton: UIButton!
    @IBOutlet weak var mondayLunchButton: UIButton!
    @IBOutlet weak var mondayDinnerButton: UIButton!
    
    @IBOutlet weak var tuesdayBreakfastButton: UIButton!
    @IBOutlet weak var tuesdayLunchButton: UIButton!
    @IBOutlet weak var tuesdayDinnerButton: UIButton!
    
    @IBOutlet weak var wednesdayBreakfastButton: UIButton!
    @IBOutlet weak var wednesdayLunchButton: UIButton!
    @IBOutlet weak var wednesdayDinnerButton: UIButton!
    
    @IBOutlet weak var thursdayBreakfastButton: UIButton!
    @IBOutlet weak var thursdayLunchButton: UIButton!
    @IBOutlet weak var thursdayDinnerButton: UIButton!
    
    @IBOutlet weak var fridayBreakfastButton: UIButton!
    @IBOutlet weak var fridayLunchButton: UIButton!
    @IBOutlet weak var fridayDinnerButton: UIButton!
    
    @IBOutlet weak var saturdayBreakfastButton: UIButton!
    @IBOutlet weak var saturdayLunchButton: UIButton!
    @IBOutlet weak var saturdayDinnerButton: UIButton!
    
    @IBOutlet weak var sundayBreakfastButton: UIButton!
    @IBOutlet weak var sundayLunchButton: UIButton!
    @IBOutlet weak var sundayDinnerButton: UIButton!
    
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        mondayBreakfastButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        mondayLunchButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        mondayDinnerButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        tuesdayBreakfastButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        tuesdayLunchButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        tuesdayDinnerButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        wednesdayBreakfastButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        wednesdayLunchButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        wednesdayDinnerButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        thursdayBreakfastButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        thursdayLunchButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        thursdayDinnerButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        fridayBreakfastButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        fridayLunchButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        fridayDinnerButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        saturdayBreakfastButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        saturdayLunchButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        saturdayDinnerButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        sundayBreakfastButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        sundayLunchButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        sundayDinnerButton.layer.cornerRadius = mondayBreakfastButton.frame.size.width / 2
        
        mondayBreakfastButton.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////
    
    @IBAction func selectBreakfast(_ sender: UIButton) {
        days[sender.tag]?.breakfast = !(days[sender.tag]?.breakfast)!
        print("\(sender.backgroundColor)")
        if sender.backgroundColor == UIColor(hexString: "#FF0000") {
            sender.backgroundColor = UIColor.cyan
        } else {
            sender.backgroundColor = UIColor(hexString: "#FF0000")
        }
    }

    @IBAction func selectLunch(_ sender: UIButton) {
        days[sender.tag]?.lunch = !(days[sender.tag]?.lunch)!
        print("\(sender.backgroundColor)")
        if sender.backgroundColor == UIColor(hexString: "#FF0000") {
            sender.backgroundColor = UIColor.cyan
        } else {
            sender.backgroundColor = UIColor(hexString: "#FF0000")
        }
    }
    
    @IBAction func selectDinner(_ sender: UIButton) {
        days[sender.tag]?.dinner = !(days[sender.tag]?.dinner)!
        print("\(sender.backgroundColor)")
        if sender.backgroundColor == UIColor(hexString: "#FF0000") {
            sender.backgroundColor = UIColor.cyan
        } else {
            sender.backgroundColor = UIColor(hexString: "#FF0000")
        }
    }
    
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        mealRequest.request = Array(days.values)
        mealRequest.budget = fracToFloat(num: budgetTextField.text!)
    }
    
    // Converts string input to float. If entry isn't valid returns 0.0
    func fracToFloat(num: String) -> Float {
        if let float = Float(num) {
            return float
        } else {
            let newString = num as NSString
            let comps = newString.components(separatedBy: "/")
            
            if let op1 = Float(comps[0]) {
                if let op2 = Float(comps[1]) {
                    return op1/op2
                }
            }
        }
        return 0.0
    }
}

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


