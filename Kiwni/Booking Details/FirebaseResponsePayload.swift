//
//  FirebaseResponsePayload.swift
//  Kiwni
//
//  Created by Shubham Shinde on 13/04/22.
//

import Foundation


struct FirebaseResponsePayload : Codable{
    let access_token : String
    let expires_in : String
    let token_type : String
    let refresh_token : String
    let id_token : String
    let user_id : String
    let project_id : String
    
    enum CodingKeys: String, CodingKey {
        case access_token = "access_token"
        case expires_in = "expires_in"
        case token_type = "token_type"
        case refresh_token = "refresh_token"
        case id_token = "id_token"
        case user_id = "user_id"
        case project_id = "project_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        access_token = try values.decode(String.self, forKey: .access_token)
        expires_in = try values.decode(String.self, forKey: .expires_in)
        token_type = try values.decode(String.self, forKey: .token_type)
        refresh_token = try values.decode(String.self, forKey: .refresh_token)
        id_token = try values.decode(String.self, forKey: .id_token)
        user_id = try values.decode(String.self, forKey: .user_id)
        project_id = try values.decode(String.self, forKey: .project_id)
    }
    
}
