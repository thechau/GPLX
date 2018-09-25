//
//  MainTableViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/12/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    class var reuseIdentifier: String {
        get {
            return "MainTableViewCell"
        }
    }
    
    var data : MainModel?{
        didSet{
            guard let datas = data else {
                return
            }
            lbDescription.text = datas.name
            imgDescription.image = UIImage(named: datas.imgDescripntion)
            imgBackground.image     = UIImage(named: datas.imgBackground)
            if let _ = imgDescription.image{
                imgDescription.image = imgDescription.image!.withRenderingMode(.alwaysTemplate)
                imgDescription.tintColor =   .white
            }
        }
    }
    
    @IBOutlet weak var imgDescription: UIImageView!{
        didSet{
            changeTinitColor()
        }
    }
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgBackground.setBorderColor(borderWidth: 0.5, borderCorlor: "cccccc")
        imgBackground.setConerRaiousFollowWidth(width: 5)
        // Initialization code
    }
    
    func changeTinitColor(){
        imgDescription.image = imgDescription.image!.withRenderingMode(.alwaysTemplate)
        imgDescription.tintColor =   .white
    }

}
