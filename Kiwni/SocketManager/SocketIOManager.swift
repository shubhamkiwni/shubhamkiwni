//
//  SocketIOManager.swift
//  Kiwni
//
//  Created by Damini on 15/04/22.
//

import Foundation
import SocketIO

let SOCKET_URL1 = "https://broadcast-service-7qkkocxieq-el.a.run.app"
let JOINT1 = "join"
let RESERVATION1 = "reservation_success"
let DRIVERDATAUPDATED = "driver_data_updated"




class SocketIOManager: NSObject {

    static let sharedInstance = SocketIOManager()
    
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    
    var reservationArray : [SocketReservationResponse] = []
    
    override init() {
        super.init()
        guard let url = URL(string: SOCKET_URL1) else {
            return
        }
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
      
        
        guard let manager = manager else {
            return
        }
        
        socket = manager.socket(forNamespace: "/users")

        socket?.on(clientEvent: .connect) {data, ack in
            print("socket connected \(data)")
           
            let myJSON = [
                "partyId": Int(partyId ?? "")
            ]
            print(myJSON)
            self.socket?.emit("join", myJSON)
            self.socket?.on(RESERVATION1) { dataArray, ack in
                print("In reservation_success")
                self.reservationArray = []
//                print(dataArray)
                do {
                    let dat = try JSONSerialization.data(withJSONObject:dataArray)
                    let res = try JSONDecoder().decode([SocketReservationResponse].self,from: dat)
                    print("resources:",res)
//                    print(res[0].id!)
                    self.reservationArray.append(contentsOf: res)
                    
                    
                } catch {
                    print(error)
                }
            }
             
            self.socket?.on(DRIVERDATAUPDATED) { dataArray, ack in
                print("DRIVER DATA UPDATED")
                self.reservationArray = []
//                print(dataArray)
                do {
                    let dat = try JSONSerialization.data(withJSONObject:dataArray)
                    let res = try JSONDecoder().decode([SocketReservationResponse].self,from: dat)
//                    print("resources:",res)
//                    print(res[0].id!)
                    self.reservationArray.append(contentsOf: res)
                    
                    
                } catch {
                    print(error)
                }
                
            }
        }
        
        socket?.connect()
    }
    
    func establishConnection() {
        socket?.connect()
    }
    
    func closeConnection() {
        socket?.disconnect()
    }
}



