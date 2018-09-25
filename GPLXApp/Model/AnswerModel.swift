//
//  AnswerModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

struct AnswerModel{
    var index : Int
    var color : UIColor
    var correct : Bool
}

struct AnswerModelCorrectOrWrong{
    var status : [Int]
}

class QuestionModelWrong: BaseDataBase{
    @objc dynamic var label: String = ""
    @objc dynamic var image : String = ""
    var answer = List<String>()
    var correctlyAnswer = List<String>()
    var correctlyChoose = List<String>()
}
