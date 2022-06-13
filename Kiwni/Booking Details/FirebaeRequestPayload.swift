//
//  FirebaeRequestPayload.swift
//  Kiwni
//
//  Created by Shubham Shinde on 13/04/22.
//

import Foundation


struct FirebaseRequestPayload : Encodable{
    let grant_type : String
    let refresh_token : String
}
