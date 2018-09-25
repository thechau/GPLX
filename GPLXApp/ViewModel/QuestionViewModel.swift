//
//  QuestionViewModel.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/13/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
//import RxCocoa
//import RxSwift
import RealmSwift

struct QuestionViewModel {
    var data : [QuestionModel] = []
    
    let arrWrong = DatabaseManager.getInstance.loadData(QuestionModelWrong.self)
    func dataAtIndex(index: Int) -> QuestionModel{
        return data[index]
    }

    mutating func setData(datas: [[String]]){
        for record in datas{
            let value = record[0].components(separatedBy: "|")
            if value.count > 5{
                var correct : [String] = []
                print("answer:\(value[6])")
                if value[6] == "1"{
                    correct = ["1"]
                }else if value[6] == "2"{
                    correct = ["2"]
                }else if value[6] == "3"{
                    correct = ["1", "2"]
                }else if value[6] == "6"{
                    correct = ["2", "3"]
                }else if value[6] == "4"{
                    correct = ["3"]
                }else if value[6] == ""{
                    correct = ["4"]
                }else if value[6] == "5"{
                    correct = ["1", "3"]
                }else if value[6] == "9"{
                    correct = ["1","4"]
                }
                
                data.append(QuestionModel(label: value[0].replacingOccurrences(of: "\\", with: ""), image: value[5], answer:[value[1], value[2], value[3], value[4]], correctlyAnswer: correct, correctlyChoose: []))
            }else if value.count > 4{
                data.append(QuestionModel(label: value[0].replacingOccurrences(of: "\\", with: ""), image: value[5], answer:[value[1], value[2], value[3], value[4]], correctlyAnswer: [value[4]], correctlyChoose: []))
            }else if value.count > 3{
                data.append(QuestionModel(label: value[0].replacingOccurrences(of: "\\", with: ""), image: "", answer:[value[1], value[2], value[3],""], correctlyAnswer: ["1"], correctlyChoose: []))
            }else if value.count == 3{
                data.append(QuestionModel(label: value[0].replacingOccurrences(of: "\\", with: ""), image: "", answer:[value[1], value[2], "", ""], correctlyAnswer: ["1"], correctlyChoose: []))
            }else if value.count == 2{
                data.append(QuestionModel(label: value[0].replacingOccurrences(of: "\\", with: ""), image: "", answer:[value[1], "", "", ""], correctlyAnswer: ["1"], correctlyChoose: []))
                
            }else{
                print(record[0])
            }
        }
    }
    
    func getGroupQuestion(data: [[String]], id: String) -> [Int]{
        var arr = [Int]()
        for record in data{
            if record[0].contains("4|") {
                let value = record[0].components(separatedBy: "|")
                if value[1] == id{
                    arr.append(Int(value[2])!)
                }
            }
        }
        return arr
        
    }
    
    mutating func dataAfterRandom(arr: [Int]){
        var datas : [QuestionModel] = []
        for index in arr{
            datas.append(data[index])
        }
        data = datas
    }
    
    
    func choiceAnswer(index: Int, answer: [String]){
        //data.value[index].correctlyChoose = answer
    }
    
    func getResult()-> (correct: Int, wrong: Int, warning: Int, result: String){
        var correct = 0
        var wrong = 0
        var warnings = 0
        var result  = "Không Đạt"
        
        for record in data{
            if record.correctlyChoose.count == 0 {
                warnings += 1
            }else if record.correctlyAnswer == record.correctlyChoose{
                correct += 1
            }else if record.correctlyAnswer != record.correctlyChoose{
                wrong += 1
            }
        }
        if correct > 12{
            result = "Đạt"
        }
        return (correct: correct, wrong: wrong, warning: warnings,result:result)
    }
    
    func getResultForReamlEachQuestion(model: QuestionModel)-> String{
        var arrAnswer = ""
        
        for record in model.correctlyChoose{
            arrAnswer = arrAnswer + "\(record)-"
        }
        
        return arrAnswer
    }
    
    func getResultForReaml()-> List<String>{
        let arrAnswer = List<String>()
        
        for record in data{
            var textAnswer = "\(record.label)-"
            for answer in record.correctlyChoose{
                textAnswer = textAnswer + "\(answer)-"
            }
            arrAnswer.append(textAnswer)
        }
        
        return arrAnswer
    }
    
    mutating func getListWrongQuestion(){
        data.removeAll()
        
        for record in arrWrong{
            //DatabaseManager.getInstance.deleteData(object: record)
            var arrAnswerCorrect : [String] = []
            for answer in record.correctlyAnswer{
                arrAnswerCorrect.append(answer)
            }

            var arrChoose : [String] = []
            for answer in record.correctlyChoose{
                arrChoose.append(answer)
            }

            var arrAns  : [String] = []
            for answer in record.answer{
                arrAns.append(answer)
            }
            data.append(QuestionModel(label: record.label, image: record.image, answer: arrAns, correctlyAnswer: arrAnswerCorrect, correctlyChoose: arrChoose))
        }
    }

    func amountData() -> Int{
        return data.count
    }
    
    mutating func convertListToArray(list: List<String>){
        var dataTemp = self.data
        
        for record in list{
            let value = record.components(separatedBy: "-") // 1-1-2-3-4-5-6
            //let index = Int(value[0])!
            
            var arrAnswer = [String]()
            if value.count > 1{
                for i in 1..<value.count{
                    if value[i] != ""{
                        arrAnswer.append(value[i])
                    }
                }
            }
            
            for record in data{
                if record.label == value[0]{
                    dataTemp.append(QuestionModel(label: record.label, image: record.image, answer: record.answer, correctlyAnswer: record.correctlyAnswer, correctlyChoose: arrAnswer))
                    break
                }
            }
            
        }
        self.data = dataTemp
    }
    
}
