//
//  SocketReservationResponse.swift
//  Kiwni
//
//  Created by Damini on 15/04/22.
//

import Foundation
struct SocketReservationResponse : Codable {
    let id : Int?
    let startLocation : String?
    let endLocation : String?
    let startTime : String?
    let endTime : String?
    let status : String?
    let rating : String?
    let createdAt : String?
    let createdByparty : SocketCreatedByparty?
    let provider : SocketProvider?
    let driver : SocketDriver?
    let passenger : SocketPassenger?
    let reservationStatus : String?
    let bookingChannel : String?
    let serviceType : String?
    let acceptedByDriverAt : String?
    let reachedLocationAt : String?
    let vehicleId : Int?
    let reservationId : Int?
    let invoiceId : String?
    let paymentId : String?
    let startLocationCity : String?
    let endlocationCity : String?
    let scheduleId : Int?
    let otp : String?
    let vehicleNo : String?
    let estimatedPrice : Double?
    let driverImageUrl : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case startLocation = "startLocation"
        case endLocation = "endLocation"
        case startTime = "startTime"
        case endTime = "endTime"
        case status = "status"
        case rating = "rating"
        case createdAt = "createdAt"
        case createdByparty = "createdByparty"
        case provider = "provider"
        case driver = "driver"
        case passenger = "passenger"
        case reservationStatus = "reservationStatus"
        case bookingChannel = "bookingChannel"
        case serviceType = "serviceType"
        case acceptedByDriverAt = "acceptedByDriverAt"
        case reachedLocationAt = "reachedLocationAt"
        case vehicleId = "vehicleId"
        case reservationId = "reservationId"
        case invoiceId = "invoiceId"
        case paymentId = "paymentId"
        case startLocationCity = "startLocationCity"
        case endlocationCity = "endlocationCity"
        case scheduleId = "scheduleId"
        case otp = "otp"
        case vehicleNo = "vehcileNo"
        case estimatedPrice = "estimatedPrice"
        case driverImageUrl = "driverImageUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        startLocation = try values.decodeIfPresent(String.self, forKey: .startLocation)
        endLocation = try values.decodeIfPresent(String.self, forKey: .endLocation)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdByparty = try values.decodeIfPresent(SocketCreatedByparty.self, forKey: .createdByparty)
        provider = try values.decodeIfPresent(SocketProvider.self, forKey: .provider)
        driver = try values.decodeIfPresent(SocketDriver.self, forKey: .driver)
        passenger = try values.decodeIfPresent(SocketPassenger.self, forKey: .passenger)
        reservationStatus = try values.decodeIfPresent(String.self, forKey: .reservationStatus)
        bookingChannel = try values.decodeIfPresent(String.self, forKey: .bookingChannel)
        serviceType = try values.decodeIfPresent(String.self, forKey: .serviceType)
        acceptedByDriverAt = try values.decodeIfPresent(String.self, forKey: .acceptedByDriverAt)
        reachedLocationAt = try values.decodeIfPresent(String.self, forKey: .reachedLocationAt)
        vehicleId = try values.decodeIfPresent(Int.self, forKey: .vehicleId)
        reservationId = try values.decodeIfPresent(Int.self, forKey: .reservationId)
        invoiceId = try values.decodeIfPresent(String.self, forKey: .invoiceId)
        paymentId = try values.decodeIfPresent(String.self, forKey: .paymentId)
        startLocationCity = try values.decodeIfPresent(String.self, forKey: .startLocationCity)
        endlocationCity = try values.decodeIfPresent(String.self, forKey: .endlocationCity)
        scheduleId = try values.decodeIfPresent(Int.self, forKey: .scheduleId)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        vehicleNo = try values.decodeIfPresent(String.self, forKey: .vehicleNo)
        estimatedPrice = try values.decodeIfPresent(Double.self, forKey: .estimatedPrice)
        driverImageUrl = try values.decodeIfPresent(String.self, forKey: .driverImageUrl)
    }

}
