//
//  GetAllProjectionScheduleRequestModel.swift
//  Kiwni
//
//  Created by Damini on 30/03/22.
//

import Foundation
struct GetAllProjectionScheduleRequestModel : Encodable {
    let  startTime: String
    let  endTime: String
    let  startLocation: String
    let  direction: String
    let  serviceType: String
    let  vehicleType: String
    let  classType : String
    let  distance: Double
    let  matchExactTime : Bool
}
