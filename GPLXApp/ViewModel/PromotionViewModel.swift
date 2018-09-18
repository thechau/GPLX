//
//  PromotionViewModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/18/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation

struct PromotionViewModel: Model{
    typealias T = PromotionModel
    
    var nameSection : String
    var data : [T] = []
    
    func amoutData() -> Int{
        return data.count
    }
    
    func dataAtIndex(index: Int) -> T{
        return data[index]
    }
}
