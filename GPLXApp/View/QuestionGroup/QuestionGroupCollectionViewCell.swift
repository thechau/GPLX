//
//  QuestionGroupCollectionViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class QuestionGroupCollectionViewCell: UICollectionViewCell, TableViewCellProtocal {
    typealias T = QuestionGroup
    
    var data: QuestionGroup? {
        didSet{
            guard let dataParse = data else {
                return
            }
            
            lbNumberWrong.text = "\(dataParse.numberWrong)"
            lbNumberCorrect.text = "\(dataParse.numberCorrect)"
            lbNameQuestion.text = dataParse.name
        }
    }
    
    class var reuseIdentifier: String {
        get {
            return "QuestionGroupCollectionViewCell"
        }
    }
    @IBOutlet weak var vwCover: UIView!
    @IBOutlet weak var lbNumberCorrect: UILabel!
    @IBOutlet weak var lbNumberWrong: UILabel!
    @IBOutlet weak var lbNameQuestion: UILabel!
}
