//
//  MealViewController.swift
//  bld
//
//  Created by Benjamin Perez on 12/2/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit
import WebKit

class MealViewController: UIViewController {
    
    var url: String?

    @IBOutlet weak var webView: UIWebView!
    var webVieww: WKWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webVieww = WKWebView()
        webView.addSubview(webVieww)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let frame = CGRect(x: 0, y: 0, width: webView.bounds.width, height: webView.bounds.height)
        webView.frame = frame
        
        loadRequest(urlStr: url!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRequest(urlStr: String) {
        
        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
    
    
    

    
}
