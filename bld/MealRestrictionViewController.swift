//
//  MealRestrictionViewController.swift
//  bld
//
//  Created by Eric Fakhourian on 11/30/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class MealRestrictionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var diet = Diet()
    
    //var selectedRows = [Restriction]()
    
    var selectedRestrictionIndex:Int?
    
    var selectedRestriction:String? {
        didSet {
            if let restriction = selectedRestriction {
                selectedRestrictionIndex = Restriction.allRestrictions.index(of: restriction)
            }
        }
    }
    
    //////////////////////////////////////////////
    //////////////////////////////////////////////

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func SubmitRestrictions(_ sender: Any) {
        createDiet()
        performSegue(withIdentifier: "SaveInitialDiet", sender: self)
    }
    
    //////////////////////////////////////////////
    //////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //////////////////////////////////////////////
    //////////////////////////////////////////////

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Restriction.allRestrictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = Restriction.allRestrictions[indexPath.row]
        
        if indexPath.row == selectedRestrictionIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedRestrictionIndex {
            let cell = tableView.cellForRow(at: NSIndexPath(item: index, section: 0) as IndexPath) as UITableViewCell!
            cell?.accessoryType = .none
        }
        
        selectedRestriction = Restriction.allRestrictions[indexPath.row]
        
        //update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    //////////////////////////////////////
    //////////////////////////////////////
    
    func createDiet() {
        diet.dietaryRestriction.append(
    }
    
    //////////////////////////////////////
    //////////////////////////////////////
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SaveInitialDiet") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! MainTabBarViewController
            // your new view controller should have property that will store passed value
            viewController.mainData.diet = diet
        }
        
    }
}
