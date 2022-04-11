//
//  ModelClassInfo.swift
//  Kiwni
//
//  Created by Damini on 11/04/22.
//

import Foundation
struct ModelClassInfo : Hashable {
   
    var modelName : String?
    var className : String?
    var opened: Bool = false
    var selectionData: [carDetails] = []
}
struct carDetails : Hashable{
    var regyear : String?
    var providername: String?
}
