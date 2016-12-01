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

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func SubmitRestrictions(_ sender: Any) {
        createDiet()
        performSegue(withIdentifier: "SaveInitialDiet", sender: self)
    }
    var names = ["Vegetarian", "Vegan", "Can Eat Anything"]
    var checkImg = [UIImage(named: "unchecked"), UIImage(named: "unchecked"), UIImage(named: "unchecked")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Restriction.allRestrictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = Restriction.allRestrictions[indexPath.row]
        
        return cell
    }
    
    //////////////////////////////////////
    //////////////////////////////////////
    
    func createDiet() {
        
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
