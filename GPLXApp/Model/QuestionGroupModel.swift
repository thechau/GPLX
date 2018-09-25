//
//  QuestionGroupModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

//struct QuestionGroup{
//    var name : String
//    var numberCorrect : Int
//    var numberWrong : Int
//    var id : Int
//}

class BaseDataBase: Object{
    @objc dynamic var identifier : Int = 0
    @objc dynamic var id              = 0
    @objc dynamic var createAt: Date? = Date()
    @objc dynamic var updateAt: Date? = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class QuestionGroupSaved: BaseDataBase{
    @objc dynamic var numberCorrect : Int = 0
    @objc dynamic var numberWrong   : Int = 0
    var arrAnswer = List<String>()
}


