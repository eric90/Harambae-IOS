//
//  foodTypePickerController.swift
//  bld
//
//  Created by Benjamin Perez on 11/27/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class FoodTypePickerController: UITableViewController {
    
    var list: [String]?
    
    var selectedType: String?
    
    var callerIdentity: String?
    
    ///////////////////////////////
    ///////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////////////////////////////////////////////////////////////////////////////
    //////////////////////// TABLE VIEW METHODS ////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
    
        let type = list?[indexPath.row]
        cell.textLabel!.text = type
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as UITableViewCell!
        
        selectedType = currentCell?.textLabel!.text
        performSegue(withIdentifier: "SaveSelectedType", sender: self)
    }
    
    ////////////////////////////////////////////////////////////////////////////
    //////////////////////////////// SEGUES ////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveSelectedType" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedType = list?[index]
                }
            }
        }
    }
    
}
