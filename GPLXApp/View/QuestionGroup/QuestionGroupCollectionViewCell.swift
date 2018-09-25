//
//  QuestionGroupCollectionViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class QuestionGroupCollectionViewCell: UICollectionViewCell, TableViewCellProtocal {
    typealias T = QuestionGroupSaved
    
    var data: QuestionGroupSaved? {
        
        didSet{
            guard let dataParse = data else {
                return
            }
            
            lbNumberWrong.text = "\(dataParse.numberWrong)"
            lbNumberCorrect.text = "\(dataParse.numberCorrect)"
            //lbNameQuestion.text = dataParse.identifier
            
            if dataParse.numberCorrect != 0 || dataParse.numberWrong != 0{
                vwCover.isHidden = true
            }else{
                vwCover.isHidden = false
            }
            
            if dataParse.numberCorrect > 12 {
                vwBackground.backgroundColor = .green
            }else if dataParse.numberWrong != 0{
                vwBackground.backgroundColor = .red
            }else {
                vwBackground.backgroundColor = .orange
            }
        }
    }
    
    class var reuseIdentifier: String {
        get {
            return "QuestionGroupCollectionViewCell"
        }
    }
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var vwCover: UIView!
    @IBOutlet weak var lbNumberCorrect: UILabel!
    @IBOutlet weak var lbNumberWrong: UILabel!
    @IBOutlet weak var lbNameQuestion: UILabel!
}
