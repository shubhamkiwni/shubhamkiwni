import Foundation
struct Rates : Codable {
	let type : String
	let id : Int
	let serviceType : String
	let category : String
	let rate : Double
	let startRange : String
	let endRange : String
	let effectFrom : String
	let effectTo : String

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case id = "id"
		case serviceType = "serviceType"
		case category = "category"
		case rate = "rate"
		case startRange = "startRange"
		case endRange = "endRange"
		case effectFrom = "effectFrom"
		case effectTo = "effectTo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
		id = try values.decode(Int.self, forKey: .id)
		serviceType = try values.decodeIfPresent(String.self, forKey: .serviceType) ?? ""
		category = try values.decodeIfPresent(String.self, forKey: .category) ?? ""
        rate = try values.decodeIfPresent(Double.self, forKey: .rate) ?? 0.0
		startRange = try values.decodeIfPresent(String.self, forKey: .startRange) ?? ""
		endRange = try values.decodeIfPresent(String.self, forKey: .endRange) ?? ""
		effectFrom = try values.decodeIfPresent(String.self, forKey: .effectFrom) ?? ""
		effectTo = try values.decodeIfPresent(String.self, forKey: .effectTo) ?? ""
	}

}
