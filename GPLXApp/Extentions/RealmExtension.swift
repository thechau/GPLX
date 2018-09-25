//
//  RealmExtension.swift
//  GPLXApp
//
//  Created by Thế Châu on 9/20/18.
//  Copyright © 2018 Thế Châu. All rights reserved.
//

import Foundation
import RealmSwift
import Foundation

class DatabaseManager {
    // ====== INSTANCE SINGLETONS ========
    class var getInstance: DatabaseManager {
        struct Static {
            static let instance: DatabaseManager! = DatabaseManager()
        }
        return Static.instance
    }
    
}

class LocalStorage: NSObject {
    class func getValueWithKey(key _key: String) -> AnyObject? {
        let obj = UserDefaults.standard.object(forKey: _key)
        return obj as AnyObject
    }
    
    class func saveDataInLocalStorage(data _data: AnyObject, key _key: String) {
        let localStorage = UserDefaults.standard
        localStorage.setValue(_data, forKey: _key)
        localStorage.synchronize()
    }
    
    class func removeDataInLocalStorage(key _key: String) {
        let localStorage = UserDefaults.standard
        localStorage.removeObject(forKey: _key)
        localStorage.synchronize()
    }
    
}

//MARK: - CREATE & UPDATE & SYNC DATA
extension DatabaseManager {
    
    /**
     *    Description: Using for create and update and sync data to table (recommend)
     */
    func createAndUpdateData<T: Object>(type _type: T.Type, object _object: Object) {
        if (_object as! BaseDataBase).id == 0 {
            (_object as! BaseDataBase).id = DatabaseManager.getInstance.incrementID(type: _type)
        }
        let realm = try! Realm()
        try! realm.write {
            realm.add(_object, update: true)
        }
    }
    
    func changeValueData<T: Object>(type _type: T.Type, object _object: Object, key _key: String, value _value: AnyObject) {
        let realm               = try! Realm()
        try! realm.write {
            _object[_key]       = _value
            realm.add(_object, update: true)
        }
    }
    
    /**
     *    Description: Using for join table company and event
     *    eventId: event Id
     *    companyId: company Id
     */
    func createQuestionGroup(identifier: Int, numberCorrect _numberCorrect: Int, numberWrong _numberWrong: Int, arrAnswer: List<String>){
        let group = QuestionGroupSaved()
        group.identifier    = identifier
        group.numberCorrect = _numberCorrect
        group.numberWrong   = _numberWrong
        group.arrAnswer     = arrAnswer
        
        createAndUpdateData(type: QuestionGroupSaved.self, object: group)
    }
    
    func createWrongQuestion(model: QuestionModel){
        let wrong = QuestionModelWrong()
        wrong.label    = model.label
        for answer in model.answer{
            wrong.answer.append(answer)
        }
        for answer in model.correctlyAnswer{
            wrong.correctlyAnswer.append(answer)
        }
        for answer in model.correctlyChoose{
            wrong.correctlyChoose.append(answer)
        }
        wrong.image             = model.image
        createAndUpdateData(type: QuestionModelWrong.self, object: wrong)
    }
    
    /**
     *    Description: Using for make Id of table increase + 1
     */
    func incrementID<T: Object>(type _type: T.Type) -> Int {
        let realm = try! Realm()
        return (realm.objects(_type).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}


//MARK: - LOAD DATA AND GET COUNT
extension DatabaseManager {
    
    /**
     *    Description: Using for get data of table
     *    T: Object mean model Database
     *    limit: count of data return you want
     *    page: ....just is page
     */
    func loadData<T: Object>(_ type: T.Type) -> List<T> {
        let realm = try! Realm()
        let dataNil = List<T>()
        let datas = realm.objects(T.self)
        for data in datas {
            dataNil.append(data)
        }
        return dataNil
    }
    
    /**
     *    Description: Using for get data of table, but return value type of [T] not list<T>
     */
    func loadDataNotList<T: Object>(_ type: T.Type, limit _limit: Int? = 0, page _page: Int? = 0, ascending _ascending: Bool? = true, sortBy _sortBy: String? = "createAt") -> [T] {
        let datas = try! Realm().objects(type).sorted(byKeyPath: _sortBy!, ascending: _ascending!)
        if _limit! * _page! > datas.count || _page! < 0 || datas.count == 0 {
            return [T]()
        } else {
            var dataReturn:[T] = [T]()
            if _limit!  != 0 {
                let from = _limit! * _page!
                let to = min(_limit! * (_page! + 1) - 1, datas.count - 1)
                var dataReturn:[T] = [T]()
                for i in from...to {
                    if !datas[i].isInvalidated {
                        dataReturn.append(datas[i])
                    }
                }
            } else {
                for data in datas {
                    if !data.isInvalidated {
                        dataReturn.append(data)
                    }
                }
            }
            return dataReturn
        }
    }
    
    /**
     *    Description: get data by id
     *    T: Object mean model Database
     */
    func loadDataById<T: Object>(_ type: T.Type, id _id: Int) -> T {
        let realm = try! Realm()
        if let dataReturn = realm.object(ofType: type, forPrimaryKey: _id) {
            if !dataReturn.isInvalidated {
                return dataReturn
            } else {
                return T()
            }
        } else {
            return T()
        }
    }
    
    func loadDataFollowFilter<T: Object>(_ type: T.Type, filter: String) -> Results<T>{
        let realm = try! Realm()
        return realm.objects(type).filter("\(filter)")
    }
    
    /**
     *    Description: Using for check model after filter is nil ?
     *    fields: name of model in database
     *    value: condition of field
     */
    func checkDataIsNil<T: Object>(_ type: T.Type, fields _fields: [String], values _values: [Int]) -> Bool{
        var filter = ""
        for i in 0..._fields.count - 1 {
            filter += "\(i > 0 ? " AND " : "")" +
            "\(_fields[i]) == \(_values[i])"
        }
        let datas = try! Realm().objects(type).filter("\(filter)")
        return datas.count > 0
    }
    
    /**
     *    Description: get count of table
     */
    func getCount<T: Object>(_ type: T.Type) -> Int {
        let realm = try! Realm()
        return realm.objects(type).count
    }
    
    /**
     *    Description: get count of table include filter
     */
//    func getCount<T: Object>(_ type: T.Type, filter _filter: DatabaseFilter) -> Int {
//        let realm       = try! Realm()
//        let filter      = getFilter(filter: _filter)
//        return realm.objects(type).filter(filter).count
//    }
    
    /**
     *    Description: return string filter depend on input: value of DatabaseFilter
     */
//    func getFilter(filter _filter: DatabaseFilter) -> String{
//        var filter = ""
//        if case let DatabaseFilter.getMasterData(cateMaster) = _filter {
//            return "cate == \(cateMaster)"
//        } else if case let DatabaseFilter.getUniversity(universityKana, department) = _filter{
//            return "universityKana == '\(universityKana)'\(department != "" ? " AND department == '\(department!)'" : "")"
//        } else if case let DatabaseFilter.getEventsByStyle(kind, createKind) = _filter {
//            return "kind == \(kind.rawValue)\(kind == EventKind.SmallEvent ? " AND createKind == \(createKind!.rawValue)" : "")"
//        } else if case let DatabaseFilter.getDataFollowFieldInt(field, id) = _filter {
//            return "\(field) == \(id)"
//        } else if case let DatabaseFilter.getRelationObogInfo(status) = _filter {
//            filter      = "status == \(status.rawValue)"
//            return filter
//        } else if case let DatabaseFilter.getDataFollowFieldString(field, value) = _filter {
//            filter      = "\(field) == \(value)"
//            return filter
//        } else if case let DatabaseFilter.getDataByOtherFilter(filterCustom) = _filter {
//            filter      = filterCustom
//            return filter
//        } else if case DatabaseFilter.getCountRelationThisMonth() = _filter {
//            let currentMonth = DateFormatUtils.getInstance.dateToString(date: Date(), dateFormatStyle: .style4)
//            filter      = "status == \(RelationsStatus.Friend.rawValue) AND inMonth == '\(currentMonth)'"
//            return filter
//        }
//        return ""
//    }
}


//MARK: - DELETE & CLEAR DATA
extension DatabaseManager {

  
    
    /**
     *    Description: using for delete data
     */
    func deleteData(object _object: Object){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(_object)
        }
    }
}
