//
//  API.swift
//  FindTripByUserID
//
//  Created by Shubham Shinde on 04/01/22.
//

import Foundation

let firebaseApiKey =  "AIzaSyB2Bq0FqEZDyE60RMmekjp8CBxFRJ0VDvc"
let baseUrl = "https://api.dev.kiwni.com/"
let userRequestURL = "https://api.dev.kiwni.com/trip/api/trips/user/\(partyId ?? "")/"
//let driverRequestURL = "https://api.dev.kiwni.com/trip/api/trips/driver/548/"
let vehicalURL = "https://api.dev.kiwni.com/projection/api/schedules/"
let projectionScheduleDateUrl = "https://api.dev.kiwni.com/projection/api/schedules/map/"
let createReservtionUrl = "\(baseUrl)reservation/api/reservations/"
let refreshTokenUrl = "https://securetoken.googleapis.com/v1/token?key=\(firebaseApiKey)"
