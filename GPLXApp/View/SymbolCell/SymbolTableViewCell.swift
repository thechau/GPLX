//
//  SymbolTableViewCell.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/14/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import UIKit

class SymbolTableViewCell: UITableViewCell, TableViewCellProtocal {
    typealias  T = SymbolModel
    @IBOutlet weak var imgSymbol: UIImageView!
    
    @IBOutlet weak var lbNameSymbol: UILabel!
    
    @IBOutlet weak var lbDescription: UILabel!
    
    var data: SymbolModel? {
        didSet{
            guard let dataParse = data else {
                return
            }
            imgSymbol.image = UIImage(named: dataParse.image)
            lbNameSymbol.text = dataParse.name
            lbDescription.text = dataParse.description
        }
    }
    
    class var reuseIdentifier: String {
        get {
            return "SymbolTableViewCell"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
