/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct location: Codable {
    let latitude: Float?
    let longitude: Float?
}

struct Json4Swift_Base : Codable {
	let id : Int?
	let startLocation : location?
	let endLocation : location?
	let startTime : String?
	let endTime : String?
	let status : String?
	let rating : String?
	let createdAt : String?
	let createdByparty : MyRideCreatedByparty?
	let provider : MyRideProvider?
	let driver : MyRideDriver?
	let passenger : MyRidePassenger?
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
	let vehcileNo : String?
	let estimatedPrice : Double?
	let driverImageUrl : String?
	let otp : String?

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
		case vehcileNo = "vehcileNo"
		case estimatedPrice = "estimatedPrice"
		case driverImageUrl = "driverImageUrl"
		case otp = "otp"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		startLocation = try values.decodeIfPresent(location.self, forKey: .startLocation)
		endLocation = try values.decodeIfPresent(location.self, forKey: .endLocation)
		startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
		endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		rating = try values.decodeIfPresent(String.self, forKey: .rating)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		createdByparty = try values.decodeIfPresent(MyRideCreatedByparty.self, forKey: .createdByparty)
		provider = try values.decodeIfPresent(MyRideProvider.self, forKey: .provider)
		driver = try values.decodeIfPresent(MyRideDriver.self, forKey: .driver)
		passenger = try values.decodeIfPresent(MyRidePassenger.self, forKey: .passenger)
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
		vehcileNo = try values.decodeIfPresent(String.self, forKey: .vehcileNo)
		estimatedPrice = try values.decodeIfPresent(Double.self, forKey: .estimatedPrice)
		driverImageUrl = try values.decodeIfPresent(String.self, forKey: .driverImageUrl)
		otp = try values.decodeIfPresent(String.self, forKey: .otp)
	}

}
