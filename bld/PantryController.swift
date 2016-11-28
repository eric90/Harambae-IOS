//
//  PantryController.swift
//  bld
//
//  Created by Benjamin Perez on 11/23/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class PantryController: UITableViewController {
    
    var selectedFoodType: FoodType?
    
    /////////////////////////////////////
    /////////////////////////////////////
    /////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /////////////////////////////////////
    // MARK: - Table view data source ///
    /////////////////////////////////////

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FoodType.allTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let category = FoodType.allTypes[indexPath.row]
        cell.textLabel!.text = category
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as UITableViewCell!
        
        selectedFoodType = FoodType(rawValue: (currentCell?.textLabel!.text)!)
        performSegue(withIdentifier: "DisplayFoodType", sender: self)
    }

    ////////////////////////////////////////
    /////////// SEGUES /////////////////////
    ////////////////////////////////////////
    
    
    ////////////////////////
    /////// TO DETAIL //////
    ////////////////////////
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DisplayFoodType") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! PantryDetailController
            // your new view controller should have property that will store passed value
            viewController.foodType = selectedFoodType
        }
        
    }
    
        
    ////////////////////////
    ///// FROM DETAIL //////
    ////////////////////////
    @IBAction func backToPantry(segue:UIStoryboardSegue) {
    }
}
