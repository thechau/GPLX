//
//  ReviewQuestionViewModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/14/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation

struct ReviewQuestionViewModel: Model{
    typealias T = ReviewQuestionModel
    var data : [T] = [ReviewQuestionModel(name: "Toàn Bộ Các Câu Hỏi", description: "351 Câu Hỏi", id: 1, data: []),
                      ReviewQuestionModel(name: "Chủ Đề: Khái Niệm Và Quy Tắc", description: "Từ Câu 1 Đến Câu 131 Câu( 131 Câu Hỏi)", id: 2, data: []),
                      ReviewQuestionModel(name: "Chủ Đề: Văn Hoá Và Đạo Đức", description: "Từ Câu 132 Đến Câu 156 Câu( 25 Câu Hỏi)", id: 3, data: []),
                      ReviewQuestionModel(name: "Chủ Đề: Biển Báo Đường Bộ", description: "Từ Câu 157 Đến Câu 256 Câu( 100 Câu Hỏi)", id: 4, data: []),
                      ReviewQuestionModel(name: "Chủ Đề: Sa Hình", description: "Từ Câu 257 Đến Câu 351 Câu( 95 Câu Hỏi)", id: 5, data: [])]
//    init(data: [T]) {
//        self.data = data
//    }
    
    func amoutData() -> Int {
        return data.count
    }
    
    func dataAtIndex(index: Int) -> T {
        return data[index]
    }
}

