//
//  DBManager.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/27.
//

import Foundation
import WCDBSwift

private let sharedInstance = DBManager()

class DBManager: NSObject {

    private let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask,
                                                        true).last! + "/DLDB/dreamLife.db"
    private lazy var db: Database = Database(at: dbPath)

    class var shareManager: DBManager {
        return sharedInstance
    }

    func createTable<T: TableCodable>(obj: T){
        let classString = GSTool.classNameAsString(obj: obj)
        let objCls = type(of: obj)
        try? db.create(table: classString, of: objCls.self)
    }

    func createTable<T: TableCodable>(cls: T.Type) {
        let classString = GSTool.classNameAsString(obj: cls)
        try? db.create(table: classString, of: cls.self)
    }


    func insert<T: TableCodable >(object: T) {
        let classString = GSTool.classNameAsString(obj: object)
        let objCls = type(of: object)
        try? db.create(table: classString, of: objCls.self)
        try? db.insert([object], intoTable: classString)
    }

    func getAllObjects<T: TableCodable>(cls: T.Type) -> [T] {
        createTable(cls: cls)
        let tableString = NSStringFromClass(cls as! AnyClass).components(separatedBy: ".").last!
        let objects: [T]? = try? db.getObjects(on: cls.Properties.all, fromTable: tableString)
        return objects ?? []
    }

    func getObjects<T: TableCodable>(cls: T.Type, where condition: Condition? = nil) -> [T]{
        createTable(cls: cls)
        let tableString = NSStringFromClass(cls as! AnyClass).components(separatedBy: ".").last!
        let objects: [T]? = try? db.getObjects(fromTable: tableString, where: condition)
        return objects ?? []
    }
}
