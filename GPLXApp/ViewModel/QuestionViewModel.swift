//
//  QuestionViewModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
import RxCocoa

struct QuestionViewModel {
    var data = BehaviorRelay<[QuestionModel]>(value: [
        QuestionModel(label: "cau 1", image: "img_bg_1", answer:["dap an a", "dap an b", "dap an c"], correctlyAnswer: 1),
        QuestionModel(label: "cau 2", image: "img_bg_1", answer:["dap an a1", "dap an b", "dap an c"], correctlyAnswer: 1),
        QuestionModel(label: "cau 3", image: "img_bg_1", answer:["dap an a2", "dap an b", "dap an c"], correctlyAnswer: 1),
        QuestionModel(label: "cau 4", image: "img_bg_1", answer:["dap an a3", "dap an b", "dap an c"], correctlyAnswer: 1),
        QuestionModel(label: "cau 5", image: "img_bg_1", answer:["dap an a4", "dap an b", "dap an c"], correctlyAnswer: 1)])
    
    func dataAtIndex(index: Int) -> QuestionModel{
        return data.value[index]
    }



    func amountData() -> Int{
        return data.value.count
    }
}
