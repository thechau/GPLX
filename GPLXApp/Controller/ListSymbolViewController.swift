//
//  ListSymbolViewController.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class ListSymbolViewController: UIViewController {

    @IBOutlet weak var tbView: UITableView!
    var model = ListSymbolViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromCSV()
        tbView.register(UINib(nibName: "SymbolTableViewCell", bundle: nil), forCellReuseIdentifier: SymbolTableViewCell.reuseIdentifier)
        // Do any additional setup after loading the view.
    }
    
    func getDataFromCSV(){
        var data = readDataFromCSV(fileName: "signs", fileType: "csv")
        data = cleanRows(file: data!)
        let csvRows = csv(data: data!)
        model.setData(datas: csvRows)
        tbView.reloadData()
    }
}

extension ListSymbolViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.dataAtIndex(index: section).amoutData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = model.dataAtIndex(index: indexPath.section).dataAtIndex(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: SymbolTableViewCell.reuseIdentifier, for: indexPath) as! SymbolTableViewCell
        cell.data = data
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.amoutData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.dataAtIndex(index: section).nameSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return configureHeaderView(tableView, section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93.5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    fileprivate func configureHeaderView(_ tableView: UITableView, _ section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        let label = UILabel(frame: CGRect(x: 16.5, y: 15, width: tableView.bounds.size.width, height: 26))
        label.textAlignment = .left
        label.text = model.dataAtIndex(index: section).nameSection
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        headerView.addSubview(label)
        return headerView
    }
}

extension ListSymbolViewController: UITableViewDelegate{
    
}










