//
//  APIManeger.swift
//  FindTripByUserID
//
//  Created by Shubham Shinde on 04/01/22.
//

import Foundation
import Alamofire

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
/*let token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjJkYzBlNmRmOTgyN2EwMjA2MWU4MmY0NWI0ODQwMGQwZDViMjgyYzAiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTmFsaW4gQ2hhbmRyYSBHaXJpIiwicGljdHVyZSI6Imh0dHA6Ly93d3cuZXhhbXBsZS5jb20vMTIzNDU2NzgvcGhvdG8ucG5nIiwiUm9sZXMiOlsiVVNFUiJdLCJwYXJ0eUlkIjoiMjY4IiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2tpd25pLXBsYXRmb3JtIiwiYXVkIjoia2l3bmktcGxhdGZvcm0iLCJhdXRoX3RpbWUiOjE2NDY2MzAyMDMsInVzZXJfaWQiOiJVU0VSLWJkMGQ4YTg1LTAwYjQtNDlkNi1iZTE4LTgxYjA5NzlkNTU4NSIsInN1YiI6IlVTRVItYmQwZDhhODUtMDBiNC00OWQ2LWJlMTgtODFiMDk3OWQ1NTg1IiwiaWF0IjoxNjQ2NjMwMjAzLCJleHAiOjE2NDY2MzM4MDMsImVtYWlsIjoibmFsaW5Aa2l3bmkuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsInBob25lX251bWJlciI6Iis5MTk1NzkzNjQ3MzUiLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7InBob25lIjpbIis5MTk1NzkzNjQ3MzUiXSwiZW1haWwiOlsibmFsaW5Aa2l3bmkuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.vrODqKIwTIoujHt01wySt4mCW2ukdxdKCkFClzPKsl7um-BvJarcu3nqCpS4jL-Aqbh7CHTUOX1bK-qdoMFVGAojRoBHtfDD-FBefBR6qcIFsopHT9eQ5H-3LGTtQNB_tp7M_xJyzwSstJShPwNn2Yh29SqhkRRjTBhVnETZeAhKQo6c5h3GuL7uH_vN16vQHb1LPK_qq5kWQ-Eqtxs-NmtD-o__YxICqJqQ62rXO7i0izMuyB89DkxqcM37yiGE9h15AfTeiGsyvy_W2BXvRi5DggYvjaD2jQEv_S9PSSaTPA0Gln201ehJHKJXN7vP9KORlsf9InBIh7tpAra4Dg"*/
let partyId = UserDefaults.standard.string(forKey: "partyId")


var dictForRegisterResponse : [String:Any]? = nil
var dictProjectionSchedule = [String : [ScheduleDate]]()

class APIManager {
    static let shareInstance = APIManager()
    let tokenheaders : HTTPHeaders   = [.authorization("Bearer \( token ?? "")")]  //[.authorization("Bearer \(token)")] //
    
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
    
    //MARK:-  scheduleDates API CALL
    func getAllProjectionAvailableSchedules(getAllProjectionData: GetAllProjectionScheduleRequestModel, completionHandler: @escaping (Result<[String : [ScheduleDate]],ClientSpecificError >) -> Void){
          AF.request(projectionScheduleMapUrl, method: .post, parameters: getAllProjectionData, encoder: JSONParameterEncoder.default, headers: tokenheaders).response { response  in
//            debugPrint(response)
              switch response.result {
              case .success(let data):
                  do {
                       
                          if response.response?.statusCode == 200 {
                            
                            dictProjectionSchedule = try JSONDecoder() .decode([String : [ScheduleDate]].self, from: data!)
                           
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
    
    
//    func callingFailuerFindTripByUserID(completion: @escaping (Result<failuerModel, Error>) -> Void) {
//        
//        AF.request(userRequestURL).response { response in
//            debugPrint(response)
//        }
//    }
}


