//
//  APIManeger.swift
//  FindTripByUserID
//
//  Created by Shubham Shinde on 04/01/22.
//

import Foundation
import Alamofire

class APIManager {
    static let shareInstance = APIManager()
    
    func callinggFindTripByUserID(completion: @escaping (Result<[Json4Swift_Base], Error>) -> Void) {
        
        AF.request(userRequestURL).response { response in
            print("User Success")
            debugPrint(response)
            DispatchQueue.main.async {
                switch response.result {
                case .success(let data):
                    do {
                        let userResponse = try JSONDecoder().decode([Json4Swift_Base].self, from: data!)
//                        print(userResponse)
                        completion(.success(userResponse))
                    } catch let err{
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
    
//    func callingFailuerFindTripByUserID(completion: @escaping (Result<failuerModel, Error>) -> Void) {
//        
//        AF.request(userRequestURL).response { response in
//            debugPrint(response)
//        }
//    }
}


