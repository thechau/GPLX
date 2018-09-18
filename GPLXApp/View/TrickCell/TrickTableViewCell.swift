//
//  TrickTableViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/17/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class TrickTableViewCell: UITableViewCell, TableViewCellProtocal {
    typealias T = String
    
    var data: TrickTableViewCell.T?{
        didSet{
            lbDescription.text = data!
        }
    }
    

    @IBOutlet weak var lbDescription: UILabel!
    class var reuseIdentifier: String {
        get {
            return "TrickTableViewCell"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
