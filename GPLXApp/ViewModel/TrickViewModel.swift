//
//  TrickViewModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/17/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation


struct TrickViewModel: Model {
    typealias T = TrickModel
    
    var data: [T] = []
    
    mutating func setData(datas: [[String]]){
        var flagNewSection = false
        var nameSection = ""
        var listSymbol : [String] = []
        for record in datas{
            var value = record[0]
            if value == "Câu khái niệm \"Phương tiện giao thông cơ giới đường bộ\" chọn \"Kể cả xe máy điện\""{
                nameSection = "Khái Niệm Và Quy Tắc"
                flagNewSection = true
            }else if value == "Hàng siêu trường, siêu trọng không thể tháo rời."{
                nameSection = "Nghiệp Vụ Vận Tải"
                flagNewSection = true
            }else if value == "Lùi xe có số tự động: Đạp phanh chân hết hành trình."{
                nameSection = "Kỹ Thuật Lái Xe"
                flagNewSection = true
            }else if value == "Niên hạn sử dụng xe ô tô tải = 25 năm, xe ô tô trên 9 chổ = 20 năm."{
                nameSection = "Cấu Tạo Và Sửa Chữa"
                flagNewSection = true
            }else if value == "Câu hỏi sa hình: Đối với câu hỏi liên quan đến việc điều khiển của CSGT, CSGT giơ tay thẳng lên thì các loại xe phải đứng lại, đưa 1 hoặc 2 tay giang ngang thì xe trước và đằng sau phải đứng lại."{
                nameSection = "Câu Hỏi Sa Hình"
                flagNewSection = true
            }else{
                flagNewSection = false
            }
            if value.contains("Câu hỏi sa hình: "){
                value = value.components(separatedBy: "Câu hỏi sa hình: ")[1]
            }
            value = value.replacingOccurrences(of: "\\", with: "")
            listSymbol.append(value)
            
            if flagNewSection && listSymbol.count > 1{
                data.append(TrickModel(nameSection: nameSection, data: listSymbol))
                listSymbol.removeAll()
            }
            
        }
    }
    
    func amoutData() -> Int {
        return data.count
    }
    
    func dataAtIndex(index: Int) -> T {
        return data[index]
    }
}
