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

    @IBOutlet weak var WbView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContents()
        // Do any additional setup after loading the view.
    }

    func loadContents(){
        do {
            guard let filePath = Bundle.main.path(forResource: "SA_Contents", ofType: "html")
                else {
                    // File Error
                    print ("File reading error")
                    return
            }
            
            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            WbView.loadHTMLString(contents as String, baseURL: baseUrl)
        }
        catch {
            print ("File HTML error")
        }
    }

}
