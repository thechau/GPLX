//
//  SymbolViewModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation

protocol Model {
    associatedtype T
    func amoutData() -> Int
    func dataAtIndex(index: Int) -> T
}

struct SymbolViewModel: Model {
    typealias T = SymbolModel
    var nameSection : String
    var data : [SymbolModel] = []
    
    func amoutData() -> Int{
        return data.count
    }
    
    func dataAtIndex(index: Int) -> T{
        return data[index]
    }
}

struct ListSymbolViewModel: Model {
    typealias T = SymbolViewModel
    var data : [SymbolViewModel] = []
    
    func amoutData() -> Int {
        return data.count
    }
    
    func dataAtIndex(index: Int) -> SymbolViewModel {
        return data[index]
    }
    
    mutating func setData(datas: [[String]]){
        var flagNewSection = false
        var nameSection = ""
        var listSymbol : [SymbolModel] = []
        for record in datas{
            let value = record[0].components(separatedBy: "|")
            if value[0] == "1"{
                nameSection = value[2]
                flagNewSection = true
            }else{
                listSymbol.append(SymbolModel(name: value[1], description: value[2], image: value[1]))
                flagNewSection = false
            }
            
            if flagNewSection && listSymbol.count > 0{
                data.append(SymbolViewModel(nameSection: nameSection, data: listSymbol))
                listSymbol.removeAll()
            }
            
        }
    }
}



