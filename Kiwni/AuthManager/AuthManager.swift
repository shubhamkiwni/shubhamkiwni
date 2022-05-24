//
//  AuthManager.swift
//  Kiwni
//
//  Created by Admin on 21/02/22.
//

import Foundation
import UIKit
import FirebaseAuth



var globalAccessToken : String!


class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    private var verificationId : String?
    var partyId : String? = ""
    var id_token : String? = ""
    var uid : String? = ""
    var email : String? = ""
    var displayName : String? = ""
    var phoneNumber  :String? = ""
    var refreshToken : String? = ""
    var roles : [String] = []
    var rolename : String = ""
    
    //MARK:- Start Auth For Phone Number
    public func startAuth(phoneNumber : String, completion: @escaping(Bool) -> Void){
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil){[weak self]verificationId, error in
            guard let verificationId = verificationId, error == nil else{
                completion(false)
                return
            }
            self?.verificationId = verificationId
            print("verificationId: \(verificationId)")
            completion(true)
        }
    }
    
    
    //MARK:- Verify SMS Code
    public func verifyCode(smsCode :String, completion: @escaping(Bool) -> Void){
        guard let verificationId = verificationId else{
            completion(false)
            return
        }
        
        //auth.settings?.isAppVerificationDisabledForTesting = true;
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: smsCode)
        
        auth.signIn(with: credential) { result, error in
            guard result != nil , error == nil else{
                completion(false)
                return
            }
            completion(true)
            
            let currentUser = Auth.auth().currentUser
            
            
            self.uid = currentUser?.uid
            self.displayName = currentUser?.displayName
            self.email = currentUser?.email
            self.phoneNumber = currentUser?.phoneNumber
            self.refreshToken = currentUser?.refreshToken
            
            
            print("uid : \(self.uid ?? "")")
            print("displayName : \(self.displayName ?? "")")
            print("email : \(self.email ?? "")")
            print("Phone Num  :\(self.phoneNumber ?? "")")
            print("Refresh Token :\(self.refreshToken ?? "")")
            
            UserDefaults.standard.setValue(self.uid, forKey: "uid")
            UserDefaults.standard.setValue(self.displayName, forKey: "displayName")
            UserDefaults.standard.setValue(self.email, forKey: "email")
            UserDefaults.standard.setValue(self.phoneNumber, forKey: "phoneNumber")
            UserDefaults.standard.setValue(self.refreshToken, forKey: "refreshToken")
            
            
            currentUser?.getIDTokenResult(completion: { [self] (result, error) in
                
                self.partyId = result?.claims["partyId"] as? String
                print("Party Id : \(self.partyId ?? "")")
                UserDefaults.standard.setValue(self.partyId, forKey: "partyId")
                
                self.id_token = result? .token
                print("id_token : \(self.id_token ?? "")")
                UserDefaults.standard.setValue(self.id_token, forKey: "idToken")
                
                self.roles = result?.claims["Roles"] as! [String]
                print("Roles : \(self.roles)")
                UserDefaults.standard.setValue(self.roles, forKey: "Roles")
                print(UserDefaults.standard.stringArray(forKey: "Roles") ?? [""])
                rolename = UserDefaults.standard.string(forKey: "Roles") ?? ""
                print("RoleName : ", rolename)
                
                if(self.roles.isEmpty){
                    return
                }
                rolename = self.roles[0]
                print("Role Name : ", rolename)
                if(rolename == "DRIVER"){
                    print("Not register as user")
                    UserDefaults.standard.setValue(false, forKey: "status")
                    let storyboard = UIStoryboard(name: "User", bundle: nil)
                    let loginVC = storyboard.instantiateViewController(identifier: Storyboard.Ids.LoginViewController) as! LoginViewController
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
                    
                }
                
            })
        }
    }
    
    func logout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Logout Done")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}
