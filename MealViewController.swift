//
//  MealViewController.swift
//  bld
//
//  Created by Benjamin Perez on 12/2/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    
    var recipe: Recipe?

    @IBOutlet weak var recipeDisplay: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDisplay.loadHTMLString(recipe!.getHTML(), baseURL: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
