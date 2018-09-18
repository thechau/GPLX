//
//  SAPhotosViewController.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/17/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit
import WebKit

class SAPhotosViewController: UIViewController {

    @IBOutlet weak var WbView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContents()
        // Do any additional setup after loading the view.
    }

    func loadContents(){
        let url = Bundle.main.url(forResource: "SA_Contents", withExtension: "html")
        WbView.load(URLRequest(url: url!))
    }

}
