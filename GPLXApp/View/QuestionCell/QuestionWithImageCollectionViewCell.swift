//
//  QuestionCollectionViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class QuestionWithImageCollectionViewCell: UICollectionViewCell {
    class var reuseIdentifier: String {
        get {
            return "QuestionWithImageCollectionViewCell"
        }
    }
    
    var data : QuestionModel? {
        didSet{
            guard let datas = data else {
                return
            }
            
            //lbAnswer1.text = datas.an
        }
    }
    
    @IBOutlet weak var lbAnswer4: UILabel!
    @IBOutlet weak var lbAnswer3: UILabel!
    @IBOutlet weak var lbAnswer2: UILabel!
    @IBOutlet weak var lbAnswer1: UILabel!
    @IBOutlet weak var radio_asw4: UIImageView!
    @IBOutlet weak var radio_asw3: UIImageView!
    @IBOutlet weak var radio_asw2: UIImageView!
    @IBOutlet weak var radio_asw1: UIImageView!
    @IBOutlet weak var vwAnswer3: UIView!
    @IBOutlet weak var vwAnswer2: UIView!
    @IBOutlet weak var vwAnswer1: UIView!
    @IBOutlet weak var vwAnswer4: UIView!
    @IBOutlet weak var imgQuestion: UIImageView!
    @IBOutlet weak var lbQuestion: UILabel!
}
