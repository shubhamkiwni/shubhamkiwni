//
//  Vehicle.swift
//  DemoFindCarAPI
//
//  Created by Damini on 30/03/22.
//


import Foundation
struct Vehicle : Codable {
    let id : Int
    let kiwniVechicleId : String
    let brand : String
    let model : String
    let color : String
    let capacity : Int
    let classType : String
    let vehicleType : String
    let regNo : String
    let baseLocation : String
    let regYear : String
    let status : String
    let driver : String
    let provider : Provider?
    let rates : [Rates]?
    let displayHeader : Bool = false
    let imagePath : String
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case kiwniVechicleId = "kiwniVechicleId"
        case brand = "brand"
        case model = "model"
        case color = "color"
        case capacity = "capacity"
        case classType = "classType"
        case vehicleType = "vehicleType"
        case regNo = "regNo"
        case baseLocation = "baseLocation"
        case regYear = "regYear"
        case status = "status"
        case driver = "driver"
        case provider = "provider"
        case rates = "rates"
        case imagePath = "imagePath"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        kiwniVechicleId = try values.decode(String.self, forKey: .kiwniVechicleId)
        brand = try values.decodeIfPresent(String.self, forKey: .brand) ?? ""
        model = try values.decodeIfPresent(String.self, forKey: .model) ?? ""
        color = try values.decodeIfPresent(String.self, forKey: .color) ?? ""
        capacity = try values.decodeIfPresent(Int.self, forKey: .capacity) ?? 0
        classType = try values.decodeIfPresent(String.self, forKey: .classType) ?? ""
        vehicleType = try values.decodeIfPresent(String.self, forKey: .vehicleType) ?? ""
        regNo = try values.decodeIfPresent(String.self, forKey: .regNo) ?? ""
        baseLocation = try values.decodeIfPresent(String.self, forKey: .baseLocation) ?? ""
        regYear = try values.decodeIfPresent(String.self, forKey: .regYear) ?? ""
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
        driver = try values.decodeIfPresent(String.self, forKey: .driver) ?? ""
        provider = try values.decodeIfPresent(Provider.self, forKey: .provider)
        rates = try values.decodeIfPresent([Rates].self, forKey: .rates)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
    }

}

