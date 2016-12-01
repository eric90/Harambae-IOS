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
    
    var names = ["Vegetarian", "Vegan", "Can Eat Anything"]
    var checkImg = [UIImage(named: "checked"), UIImage(named: "checked"), UIImage(named: "checked")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Restriction.allRestrictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.ImgCheck.image = checkImg[indexPath.row]
        cell.LblMeal.text = Restriction.allRestrictions[indexPath.row]
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
