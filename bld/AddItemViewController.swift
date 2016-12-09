//
//  AddItemViewController.swift
//  bld
//
//  Created by Benjamin Perez on 11/25/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    var ingredient: Ingredient?
    
    var chosenFieldList: [String]?
    
    var selectedField: String?
    
    //////////////////////////////////////////////////////
    //////////////////////////////////////////////////////

    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var unitLabel: UILabel!
    
    
    //////////////////////////////////////////////////////
    //////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //////////////////////////////////////////////////////
    /////////////////// TABLE VIEW ///////////////////////
    //////////////////////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            itemNameTextField.becomeFirstResponder()
        } else if indexPath.section == 1 {
            amountTextField.becomeFirstResponder()
        } else if indexPath.section == 2 {
            chosenFieldList = Unit.allUnits
            selectedField = "Units"
            performSegue(withIdentifier: "PickType", sender: self)
        } else if indexPath.section == 3 {
            chosenFieldList = FoodType.allTypes
            selectedField = "Type"
            performSegue(withIdentifier: "PickType", sender: self)
        }
    }
    
    //////////////////////////////////////////////////////
    ////////////////// SEGUES ////////////////////////////
    //////////////////////////////////////////////////////
    
    ///////////////////////////
    ///// TO TYPE PICKER //////
    ///////////////////////////
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PickType") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! FoodTypePickerController
            // your new view controller should have property that will store passed value
            viewController.list = chosenFieldList
            viewController.callerIdentity = selectedField
            
        } else if segue.identifier == "SaveItemDetail" {
            let itemType = FoodType(rawValue: typeLabel.text!)
            let itemUnit = Unit(rawValue: unitLabel.text!)
            let itemName = itemNameTextField.text!
            let itemAmount = fracToFloat(num: amountTextField.text!)
            ingredient = Ingredient(name: itemName, type: itemType!, amount: Double(itemAmount), unit: itemUnit!)
        }
        
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
    
    ///////////////////////////
    ///// FROM TYPE PICKER ////
    ///////////////////////////
    
    func unwindWithSelectedType(segue:UIStoryboardSegue) {
        if let foodTypePickerController = segue.source as? FoodTypePickerController {
            let selectedType = foodTypePickerController.selectedType
            if selectedField == "Units" {
                unitLabel.text = "\(selectedType!)"
            } else if selectedField == "Type" {
                typeLabel.text = "\(selectedType!)"
            }
        }
    }
}
