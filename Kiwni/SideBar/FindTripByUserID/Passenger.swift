
import Foundation
struct MyRidePassenger : Codable {
	let id : Int?
	let name : String?
	let email : String?
	let mobile : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case email = "email"
		case mobile = "mobile"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
	}

}
