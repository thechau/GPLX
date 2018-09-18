//
//  ReviewQuestionTableViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/14/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class ReviewQuestionTableViewCell: UITableViewCell, TableViewCellProtocal {
    typealias T = ReviewQuestionModel
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    var data: ReviewQuestionModel?{
        didSet{
            guard let dataParse = data else {
                return
            }
            
            lbName.text = dataParse.name
            lbDescription.text = dataParse.description
        }
    }
    
    class var reuseIdentifier: String {
        get {
            return "ReviewQuestionTableViewCell"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
