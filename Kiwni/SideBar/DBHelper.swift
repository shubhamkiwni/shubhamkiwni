//
//  DBHelper.swift
//  FindTripByUserID
//
//  Created by Shubham Shinde on 01/03/22.
//

import Foundation
import SQLite3
class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "FindTripByUserIDDB.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        
        
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        print(fileURL)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
            
        }
        
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(id DOUBLE PRIMARY KEY,startLocationCity TEXT,endlocationCity TEXT,startTime TEXT,endTime TEXT,status TEXT,estimatedPrice DOUBLE,serviceType TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
                
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(id:Double, startLocationCity:String, endlocationCity: String, startTime:String, endTime:String, status: String, estimatedPrice:Double, serviceType: String) {
//        let persons = read()
//        for p in persons
//        {
//            if p.id == id
//            {
//                print("Data exist")
//                return
//            }
//        }
        let insertStatementString = "INSERT INTO person (id, startLocationCity, endlocationCity, startTime, endTime, status, estimatedPrice, serviceType) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_double(insertStatement, 1, Double(id))
            sqlite3_bind_text(insertStatement, 2, (startLocationCity as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (endlocationCity as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (startTime as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (endTime as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (status as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 7, Double(estimatedPrice))
            sqlite3_bind_text(insertStatement, 8, (serviceType as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Person] {
        let queryStatementString = "SELECT * FROM person;"
        var queryStatement: OpaquePointer? = nil
        var psns: [Person] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_double(queryStatement, 0)
                let startLocationCity = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let endlocationCity = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let startTime = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let endTime = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let status = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let estimatedPrice = sqlite3_column_double(queryStatement, 6)
                let serviceType = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                psns.append(Person(id: id, startLocationCity: startLocationCity, endlocationCity: endlocationCity, startTime: startTime, endTime: endTime, status: status, estimatedPrice: estimatedPrice, serviceType: serviceType))
                print("Query Result:")
                print("\(id) | \(startLocationCity) | \(endlocationCity) | \(startTime) | \(endTime) | \(status) | \(estimatedPrice) | \(serviceType)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }

    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM person WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_double(deleteStatement, 1, Double(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}


class Person
{
    
    var id: Double = 00
    var startLocationCity: String = ""
    var endlocationCity: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var status: String = ""
    var estimatedPrice: Double = 00
    var serviceType: String = ""
    
    init(id:Double, startLocationCity:String, endlocationCity:String, startTime:String, endTime: String, status:String, estimatedPrice:Double, serviceType:String)
    {
        self.id = id
        self.startLocationCity = startLocationCity
        self.endlocationCity = endlocationCity
        self.startTime = startTime
        self.endTime = endTime
        self.status = status
        self.estimatedPrice = estimatedPrice
        self.serviceType = serviceType
    }
    
}
