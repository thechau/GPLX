//
//  MainViewModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/12/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel {
    var data  = BehaviorRelay<[MainModel]>(value: [MainModel(imgDescripntion: "img_description_0", imgBackground: "img_bg_1", name: "Đề Ngẫu Nhiên"),
                                                   MainModel(imgDescripntion: "img_description_1", imgBackground: "img_bg_1", name: "Thi Theo Bộ Đề"),
                                                   MainModel(imgDescripntion: "img_description_2", imgBackground: "img_bg_1", name: "Ôn Theo Câu Hỏi"),
                                                   MainModel(imgDescripntion: "img_description_3", imgBackground: "img_bg_1", name: "Xem Câu Bị Sai"),
                                                   MainModel(imgDescripntion: "img_description_4", imgBackground: "img_bg_4", name: "Các Biển Báo"),
                                                   MainModel(imgDescripntion: "img_description_5", imgBackground: "img_bg_5", name: "Mẹo"),
                                                   MainModel(imgDescripntion: "img_description_6", imgBackground: "img_bg_7", name: "Sa Hình"),
                                                   MainModel(imgDescripntion: "img_description_7", imgBackground: "img_bg_7", name: "Khuyến Mãi")])
    
    func dataAtIndex(index: Int) -> MainModel{
        return data.value[index]
    }
    
    func amountData() -> Int{
        return data.value.count
    }
}
