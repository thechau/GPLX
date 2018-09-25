//
//  PromotionTableViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/18/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class PromotionTableViewCell: UITableViewCell, TableViewCellProtocal {
    typealias T = PromotionModel
    var data: PromotionTableViewCell.T?{
        didSet{
            lbName.text = data!.title
            lbDescription.text  = data!.content
            lbLink.text         = data!.link
        }
    }
    
    class var reuseIdentifier: String {
        get {
            return "PromotionTableViewCell"
        }
    }
    
    @IBOutlet weak var lbLink: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
