//
//  PantryDetailController.swift
//  bld
//
//  Created by Benjamin Perez on 11/26/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class PantryDetailController: UITableViewController {
    
    var pantry = Pantry()
    
    var foodType: FoodType?
    
    ////////////////////////////////////////////////////////////////
    /////////////////// LOAD METHODS ///////////////////////////////
    ////////////////////////////////////////////////////////////////

    override func viewDidLoad() {
        self.title = "\(foodType!)"
        tableView.reloadData()
        super.viewDidLoad()
        let mainController = self.tabBarController  as! MainTabBarViewController
        pantry = mainController.mainData.pantry
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    ////////////////////////////////////////////////////////////////
    ////////////// TABLE VIEW METHODS //////////////////////////////
    ////////////////////////////////////////////////////////////////

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pantry.ingredients[foodType!]!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let sectionList = pantry.ingredients[foodType!]!
        let item = sectionList[indexPath.row]
        cell.textLabel!.text = item.name
        cell.detailTextLabel!.text = "\(item.amount)" + "\(item.unit)"
        return cell
    }
    
    private func orderIngredients(first: Ingredient, second: Ingredient) -> Bool {
        return (first.name < second.name)
    }
    
    ////////////////////////////////////////////////////////////////
    ////////////////// SEGUE METHODS ///////////////////////////////
    ////////////////////////////////////////////////////////////////
    
    
    ///////////////////////////
    ///// FROM ADD ITEM ///////
    ///////////////////////////
    @IBAction func cancelAddPantryDetailController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveItemPantryDetailController(segue:UIStoryboardSegue) {
        if let addItemViewController = segue.source as? AddItemViewController {
            if let ingredient = addItemViewController.ingredient {
                pantry.ingredients[ingredient.type!]?.append(ingredient)
                pantry.ingredients[ingredient.type!]?.sort(by: orderIngredients)
                tableView.reloadData()
            }
        }
    }

}
