//
//  WebViewController.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/25/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var titles = ""
    var linkURL =  ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContents()
        // Do any additional setup after loading the view.
    }
    
    func loadContents(){
        let url = URL(string: linkURL)
        webView.loadRequest(URLRequest(url: url!))
    }

}
