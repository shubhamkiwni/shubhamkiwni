import Foundation
struct ScheduleDate : Codable {
    let id : Int
    let createdBy : String
    let updatedBy : String
    let availableLocation : String
    let startTime : String
    let endTime : String
    let status : String
    let driverId : Int
    let driverName : String
    let driverMobileNo : String
    let model : String
    let vehicle : Vehicle?
    let price : Double
    let priceString : String
    var isHeader: Bool = false
    var availableCount : Int = 0
    let matchExactTime : Bool = false
    let imagePath : String
   

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case createdBy = "createdBy"
        case updatedBy = "updatedBy"
        case availableLocation = "availableLocation"
        case startTime = "startTime"
        case endTime = "endTime"
        case model = "model"
        case status = "status"
        case driverId = "driverId"
        case driverName = "driverName"
        case driverMobileNo =  "driverMobileNo"
        case vehicle = "vehicle"
        case price = "price"
        case imagePath = "imagePath"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy) ?? ""
        updatedBy = try values.decodeIfPresent(String.self, forKey: .updatedBy) ?? ""
        availableLocation = try values.decodeIfPresent(String.self, forKey: .availableLocation) ?? ""
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime) ?? ""
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime) ?? ""
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
        driverId = try values.decodeIfPresent(Int.self, forKey: .driverId) ?? 0
        driverName = try values.decodeIfPresent(String.self, forKey: .driverName) ?? ""
        driverMobileNo = try values.decodeIfPresent(String.self, forKey: .driverMobileNo) ?? ""
        vehicle = try values.decodeIfPresent(Vehicle.self, forKey: .vehicle)
        price = try values.decodeIfPresent(Double.self, forKey: .price) ?? 0.0
        priceString = try String(format: "%.2f", values.decodeIfPresent(Double.self, forKey: .price) ?? 0.0)
        model = try values.decodeIfPresent(String.self, forKey: .model) ?? ""
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
        
    }

}

