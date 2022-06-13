//
//  DataBaseHelper.swift
//  DemoCoreData
//
//  Created by Damini on 02/06/22.
//

import Foundation
import CoreData
import UIKit

class DataBaseHelper {
    
    static var shareinstance = DataBaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    func saveData(object : [String:String]) {
        let locationAddress = NSEntityDescription.insertNewObject(forEntityName: "LocationAddress", into: context!) as! LocationAddress
        locationAddress.addressValue = object["addressValue"]
        locationAddress.addressType = object["addressType"]
        locationAddress.addressLat = object["addressLat"]
        locationAddress.addressLong = object["addressLong"]        
        do {
            try context?.save()
        } catch {
            print("Data is not saved")
        }
    }
    
    func getData() -> [LocationAddress] {
        var employee = [LocationAddress]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LocationAddress")
        do {
            employee = try context?.fetch(fetchRequest) as! [LocationAddress]
        } catch {
            print("can not get data")
        }
        return employee
    }
    
    func editData(object: [String:String], i: Int) {
        let address = getData()
        address[i].addressType = object["addressType"]
        address[i].addressValue = object["addressValue"]
        address[i].addressLat = object["addressLat"]
        address[i].addressLong = object["addressLong"]
        //            i.addressValue = object["addressValue"]
        //            i.addressType = object["addressType"]
        //            i.addressLat = object["addressLat"]
        //            i.addressLong = object["addressLong"]
        do {
            try context?.save()
        } catch {
            print("data is not edit")
        }
    }
    
//    func editData(object:[String:String]) {
//        let address = getData()
//        for i in address {
//            i.addressValue = object["addressValue"]
//            i.addressType = object["addressType"]
//            i.addressLat = object["addressLat"]
//            i.addressLong = object["addressLong"]
//        }
//
//
//        do {
//            try context?.save()
//            print("data is edit successfully")
//        } catch {
//            print("data is not edit")
//        }
//
//    }
    
    
//    func update(identifier: String, addressNewValue: String, addressLatCordinate : String, addressLongCordinate : String) {
//
//       // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "LocationAddress")
//        let predicate = NSPredicate(format: "ID = '\(identifier)'")
//        fetchRequest.predicate = predicate
//        do
//        {
//            let object = try context?.fetch(fetchRequest)
//            if object?.count == 1
//            {
//                let objectUpdate = object?.first as! NSManagedObject
//                objectUpdate.setValue(addressNewValue, forKey: "addressValue")
//                objectUpdate.setValue(addressLatCordinate, forKey: "addressLat")
//                objectUpdate.setValue(addressLongCordinate, forKey: "addressLong")
//
//                do{
//                    try context?.save()
//                }
//                catch
//                {
//                    print(error)
//                }
//            }
//        }
//        catch
//        {
//            print(error)
//        }
//    }
    
}
