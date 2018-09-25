//
//  QuestionModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

struct QuestionModel: RealmCollectionValue {
    var label: String
    var image : String
    var answer : [String] = []
    var correctlyAnswer : [String]
    var correctlyChoose : [String]
}
