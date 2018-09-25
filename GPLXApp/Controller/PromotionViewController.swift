//
//  PromotionViewController.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/17/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class PromotionViewController: UIViewController {

    @IBOutlet weak var tbView: UITableView!
    var model = PromotionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.register(UINib(nibName: "PromotionCell", bundle: nil), forCellReuseIdentifier: PromotionTableViewCell.reuseIdentifier)
        // Do any additional setup after loading the view.
        tbView.rowHeight = 120
        
        model.getData(completion: { (data) in
            DispatchQueue.main.async {
                self.model.data = data
                self.tbView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    
}


extension PromotionViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.amoutData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PromotionTableViewCell.reuseIdentifier, for: indexPath) as! PromotionTableViewCell
        let data = model.dataAtIndex(index: indexPath.row)
        cell.data = data
        return cell
    }
}
