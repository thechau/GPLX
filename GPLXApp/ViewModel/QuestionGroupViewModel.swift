//
//  QuestionGroupModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
//import RxSwift
//import RxCocoa
import RealmSwift
import Realm

struct QuestionGroupViewModel {
    var data : List<QuestionGroupSaved>  = DatabaseManager.getInstance.loadData(QuestionGroupSaved.self)
    
    func dataAtIndex(index: Int) -> QuestionGroupSaved?{
        for record in data {
            if record.identifier == index + 1{
                return record
            }
        }
        return nil
    }
    
    func clearData(){
        for record in data{
            DatabaseManager.getInstance.deleteData(object: record)
        }
    }
    
    func amountData() -> Int{
        return data.count
    }
}
