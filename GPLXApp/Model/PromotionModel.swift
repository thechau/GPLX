//
//  PromotionModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/18/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation

struct PromotionModel: Decodable{
    var title: String
    var content: String
    var link: String
}

struct ParsePromotionModel: Decodable{
    var data : [PromotionModel]
}
