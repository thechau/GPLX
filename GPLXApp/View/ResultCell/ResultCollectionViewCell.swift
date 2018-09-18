//
//  ResultCollectionViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    class var reuseIdentifier: String {
        get {
            return "ResultCollectionViewCell"
        }
    }
    @IBOutlet weak var lbNumberQuestion: UILabel!
    @IBOutlet weak var imgResult: UIImageView!
}
