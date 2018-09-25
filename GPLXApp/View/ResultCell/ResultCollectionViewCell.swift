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
    
    var data : QuestionModel? {
        didSet{
            imgResult.setShadow()
            self.setConerRaiousFollowWidth(width: 1)
            if data?.correctlyChoose.count == 0{
                imgResult.image = #imageLiteral(resourceName: "ico_warning")
            }else if data?.correctlyChoose == data?.correctlyAnswer{
                imgResult.image = #imageLiteral(resourceName: "ico_correct")
            }else if data?.correctlyChoose != data?.correctlyAnswer{
                imgResult.image = #imageLiteral(resourceName: "ico_wrong")
            }
            
        }
        
    }
    
    @IBOutlet weak var lbNumberQuestion: UILabel!
    @IBOutlet weak var imgResult: UIImageView!
}
