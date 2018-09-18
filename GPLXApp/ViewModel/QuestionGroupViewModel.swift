//
//  QuestionGroupModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct QuestionGroupViewModel {
    var data = BehaviorRelay<[QuestionGroup]>(value: [QuestionGroup(name: "Bo de 1", numberCorrect: 10, numberWrong: 10, id: 1),
                                                      QuestionGroup(name: "Bo de 1", numberCorrect: 10, numberWrong: 10, id: 1),
                                                      QuestionGroup(name: "Bo de 1", numberCorrect: 10, numberWrong: 10, id: 1),
                                                      QuestionGroup(name: "Bo de 1", numberCorrect: 10, numberWrong: 10, id: 1)])
    
    func dataAtIndex(index: Int) -> QuestionGroup{
        return data.value[index]
    }
    
    
    
    func amountData() -> Int{
        return data.value.count
    }
}
