//
//  ModelClassInfo.swift
//  Kiwni
//
//  Created by Damini on 11/04/22.
//

import Foundation
struct ModelClassInfo : Hashable {
   
    var modelName : String? = ""
    var className : String? = ""
    var imagePath  : String? = ""
    var opened: Bool = false
    var estimatedPrice : Double = 0
    var selectionData: [carDetails] = []
}
struct carDetails : Hashable{
    var regyear : String? = ""
    var providername: String? = ""
    var providerID: String? = ""
    var vehicalID: Int? = 0
    var vehicleNumb: String? = ""
    var driverID: Int? = 0
    var driverLicense: String? = ""
    var driverName: String? = ""
    var driverPhone: String? = ""
    var scheduleID: Int? = 0
    var distance: String? = ""
    var fromLocation: String? = ""
    var toLocation: String? = ""
    var journeyEndTime: String? = ""
    var journeyTime: String? = ""
    var estimatedPrice: Double? = 0
    var rate : [Rates] = []
//    var carRates: [VehicalRates] = []
}

struct VehicalRates: Hashable {
    let id : Int = 0
    let serviceType : String = ""
    let category : String = ""
    let rate : Double = 0
}

