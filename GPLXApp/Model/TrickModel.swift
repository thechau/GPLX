//
//  TrickModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/17/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
struct TrickModel: Model {
    
    typealias T = String
    var nameSection = ""
    var data : [String] = []
    
    func amoutData() -> Int {
        return data.count
    }
    
    func dataAtIndex(index: Int) -> String {
        return data[index]
    }
}
