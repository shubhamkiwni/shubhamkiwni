//
//  CarsDetail.swift
//  Kiwni
//
//  Created by Damini on 23/03/22.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    var sedan, suv, tempo: [Sedan]

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
