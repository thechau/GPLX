//
//  PromotionViewModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/18/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation

struct PromotionViewModel: Model{
    typealias T = PromotionModel
    var data : [T] = []
    
    func amoutData() -> Int{
        return data.count
    }
    
    func dataAtIndex(index: Int) -> T{
        return data[index]
    }
    
    mutating func getData(completion: @escaping (_ _data: [T]) -> Void){
        let urlString = "https://5ba9e39253adf70014d15c2b.mockapi.io/news"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (datas, response, err ) in
            guard let datas = datas else { return }
            
            do {
                let datas =  try JSONDecoder().decode(ParsePromotionModel.self, from: datas)//.decode([PromotionModel.self], from: datas)
                completion(datas.data)
            }catch let json {
                print(json)
            }
        }.resume()
    }
    //func 
}
