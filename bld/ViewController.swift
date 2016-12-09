//
//  ViewController.swift
//  bld
//
//  Created by Eric Fakhourian on 11/15/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func SignIn(_ sender: Any) {
        
    }
    
    @IBOutlet weak var signIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signIn.layer.cornerRadius = 15
        signIn.clipsToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

