//
//  TopQuestionCollectionViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class TopQuestionCollectionViewCell: UICollectionViewCell {
    class var reuseIdentifier: String {
        get {
            return "TopQuestionCollectionViewCell"
        }
    }
    
    var data : AnswerModel? {
        willSet{
            lbTitle.isHidden = false
        }
        didSet{
            lbTitle.setShadow()
            //self.vwBackground.setShadow()
            if data!.index == 0{
                lbTitle.isHidden = true
                return
            }
            lbTitle.text = "Câu \(data!.index)"
            vwBackground.backgroundColor = data!.color
        }
    }
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vwBackground: UIView!
}
