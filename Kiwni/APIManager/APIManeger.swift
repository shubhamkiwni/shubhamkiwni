//
//  APIManeger.swift
//  FindTripByUserID
//
//  Created by Shubham Shinde on 04/01/22.
//

import Foundation
import Alamofire

enum APIErrors : Error {
   case custom(message :String)
}

enum BaseError: Error {
    case badRequest // 400
    case unauthorized // 401
    case forbidden // 403
    case internalservererror // 500
    case notfound // 404
}


enum ClientSpecificError: Error {
    case clientError
    case baseError(BaseError)
}


let token = UserDefaults.standard.string(forKey: "idToken")
let partyId = UserDefaults.standard.string(forKey: "partyId")


var dictForRegisterResponse : [String:Any]? = nil
//var dictProjectionSchedule = [String : [ScheduleDate]]()
var dictProjectionSchedule = [String:[String:[String: [VehicleDetails]]]]()

class APIManager {
    static let shareInstance = APIManager()
    let tokenheaders : HTTPHeaders   = [.authorization("Bearer \( token ?? "")")]  //[.authorization("Bearer \(token)")] //
    let refershtokenheader : HTTPHeaders = [.contentType("application/json")]
    func callinggFindTripByUserID(completion: @escaping (Result<[Json4Swift_Base], Error>) -> Void) {
        
        AF.request(pastTripRequestURL).response { response in
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
    
    func callinggInProgressTripRequest(completion: @escaping (Result<[Json4Swift_Base], Error>) -> Void) {
        
        AF.request(upcomingTripRequestURL).response { response in
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
    
    //MARK:-  scheduleDates API CALL
    func getAllProjectionAvailableSchedules(getAllProjectionData: GetAllProjectionScheduleRequestModel, completionHandler: @escaping (Result<[String:[String:[String: [VehicleDetails]]]],ClientSpecificError >) -> Void){
          AF.request(projectionScheduleDateUrl, method: .post, parameters: getAllProjectionData, encoder: JSONParameterEncoder.default, headers: tokenheaders).response { response  in
//            debugPrint(response)
              switch response.result {
              case .success(let data):
                  do {
                       
                          if response.response?.statusCode == 200 {
                            
                              dictProjectionSchedule = try JSONDecoder() .decode([String:[String:[String:[VehicleDetails]]]].self, from: data!)
                           
                            completionHandler(.success(dictProjectionSchedule))
                            
                          }
                          else if response.response?.statusCode == 400 {
                            
                            completionHandler(.failure(.baseError(.badRequest)))
   //                            completionHandler(.failure(Error.self as! Error))
                            
                            //completionHandler(.failure(Error.self as! Error))
                          }
                          else if response.response?.statusCode == 401 {
                            completionHandler(.failure(.baseError(.unauthorized)))
//                            completionHandler(.failure(.custom(message: "UnAuthorized")))
                            //completionHandler(.failure(Error.self as! Error))
                          
                          }else if response.response?.statusCode == 500 {
                            completionHandler(.failure(.baseError(.internalservererror)))
                            
                            //completionHandler(.failure(.custom(message: "Internal Server Error")))
                            //completionHandler(.failure(Error.self as! Error))
                          }
                          else {
                            completionHandler(.failure(.baseError(.notfound)))
                            //completionHandler(.failure(.custom(message: "Check check your network conttectivity")))
                          }
                  } catch {
                      print(error.localizedDescription)
                    //completionHandler(.failure(.custom(message: "Check check your network conttectivity")))
                  }
              case.failure(let err):
                  print(err.localizedDescription)
                //completionHandler(.failure(.custom(message: "Connection issue")))
                  print(err)
              }
          }
      }
    //MARK:- Create Reservation API CALL
    func createReservationForVehicleSchedule(getReservationModel: ReservationScheduleModel, completionHandler: @escaping (Result<Any, APIErrors>) -> Void){
          AF.request(createReservtionUrl, method: .post, parameters: getReservationModel, encoder: JSONParameterEncoder.default, headers: tokenheaders).response { response  in
            debugPrint(response)
              switch response.result {
              case .success(let data):
                  do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                       
                          if response.response?.statusCode == 201 {
                          
                            completionHandler(.success(json))
                          }
                          else if response.response?.statusCode == 400 {
                            
//                                completionHandler(.failure("Bad Request"))
                            completionHandler(.failure(.custom(message: "Bad Request")))
//                            completionHandler(.failure(Error.self as! Error))
                            
                            //completionHandler(.failure(Error.self as! Error))
                          }
                          else if response.response?.statusCode == 401 {
                            completionHandler(.failure(.custom(message: "UnAuthorized")))
                            //completionHandler(.failure(Error.self as! Error))
                          
                          }else if response.response?.statusCode == 500 {
                            
                            completionHandler(.failure(.custom(message: "Internal Server Error")))
              
                            //completionHandler(.failure(Error.self as! Error))
                          }
                          else
                          {
                            completionHandler(.failure(.custom(message: "Check check your network conttectivity")))
                          }
                  } catch {
                      print(error.localizedDescription)
                  }
              case.failure(let err):
                  print(err.localizedDescription)
                  print(err)
                
              }
          }
      }

   
    func getRefreshToken(requestpayloadModel : FirebaseRequestPayload , completionHandler: @escaping (Result<FirebaseResponsePayload, APIErrors>) -> Void){
        AF.request(refreshTokenUrl, method: .post, parameters: requestpayloadModel, encoder: JSONParameterEncoder.default, headers: refershtokenheader).response { response  in
          debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(FirebaseResponsePayload.self, from: data!)
                    print(json)
                    completionHandler(.success(json))
                      
                } catch {
                    print(error.localizedDescription)
                }
            case.failure(let err):
                print(err.localizedDescription)
                print(err)
              
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


