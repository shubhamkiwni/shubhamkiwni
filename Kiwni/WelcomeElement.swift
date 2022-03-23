//
//  CarDetails.swift
//  Kiwni
//
//  Created by Shubham Shinde on 23/03/22.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    var sedan, suv, tempo: [Sedan]?

    enum CodingKeys: String, CodingKey {
        case sedan = "Sedan"
        case suv = "Suv"
        case tempo = "Tempo"
    }
}

// MARK: - Sedan
struct Sedan: Codable {
    var carType, availabel, fare, ac: String
    var seater, bags: String
    var cars: [Car]

    enum CodingKeys: String, CodingKey {
        case carType, availabel, fare
        case ac = "AC"
        case seater, bags, cars
    }
}

// MARK: - Car
struct Car: Codable {
    var carName, serviceType, availabel, fare: String
    var carModels: [CarModel]
}

// MARK: - CarModel
struct CarModel: Codable {
    var modelYear, ratings, fare: String
}

typealias Welcome = [WelcomeElement]
