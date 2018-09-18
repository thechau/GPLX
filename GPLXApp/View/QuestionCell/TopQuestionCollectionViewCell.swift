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
        didSet{
            lbTitle.text = "Câu \(data!.index)"
            vwBackground.backgroundColor = data!.color
        }
    }
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vwBackground: UIView!
}
