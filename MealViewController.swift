//
//  MealViewController.swift
//  bld
//
//  Created by Benjamin Perez on 12/2/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    
    var url: String?

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
