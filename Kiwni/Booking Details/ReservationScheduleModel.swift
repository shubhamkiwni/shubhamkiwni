// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reservationScheduleResponseModel = try? newJSONDecoder().decode(ReservationScheduleResponseModel.self, from: jsonData)

import Foundation

// MARK: - ReservationScheduleResponseModel
struct ReservationScheduleModel: Codable {
    let channel: Channel
    let createdTime, createdUser, customerEmail: String
    let customerID: Int
    let customerName, customerPhone: String
    let driverID: Int
    let driverLicense, driverName, driverPhone: String
    let providerID: Int
    let providerName, reservationTime: String
    let ride: Ride
    let scheduleID: Int
    let serviceType, status: Channel
    let updatedTime, updatedUser: String
    let vehicleID: Int
    let estimatedPrice : Double
    let vehicleNo : String

    enum CodingKeys: String, CodingKey {
        case channel, createdTime, createdUser, customerEmail
        case customerID = "customerId"
        case customerName, customerPhone
        case driverID = "driverId"
        case driverLicense, driverName, driverPhone
        case providerID = "providerId"
        case providerName, reservationTime, ride, vehicleNo
        case scheduleID = "scheduleId"
        case serviceType, status, updatedTime, updatedUser
        case vehicleID = "vehicleId"
        case estimatedPrice
    }
}

// MARK: - Channel
struct Channel: Codable {
    let id: Int
}

// MARK: - Ride
struct Ride: Codable {
    let createdTime, createdUser, distance, fromLocation: String
    let journeyEndTime, journeyTime: String
    let rates: [Channel]
    let status: Channel
    let toLocation, updatedTime, updatedUser: String
}

