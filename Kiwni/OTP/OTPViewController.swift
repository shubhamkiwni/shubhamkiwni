//
//  OTPViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 31/01/22.
//

import UIKit
import Reachability
import FirebaseAuth
class OTPViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var enterNumberLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var otpText1: UITextField!
    @IBOutlet weak var otpText2: UITextField!
    @IBOutlet weak var otpText3: UITextField!
    @IBOutlet weak var otpText4: UITextField!
    @IBOutlet weak var otpText5: UITextField!
    @IBOutlet weak var otpText6: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var reserndOTPButton: UIButton!
    
    var userMobileNumber : String? = ""
    var otp  = [String]()
    var userEnterdOtp : String = ""
    let reachability = try! Reachability()
   
    var getVerifyCode : String?
    var partyId : String? = ""
    var id_token : String? = ""
    var uid : String? = ""
    var email : String? = ""
    var displayName : String? = ""
    var phoneNumber  :String? = ""
    var refreshToken : String? = ""
    var roles : [String] = []
    var rolename : String = ""
    var otpCode = String()
    
    var counter = 0
    var timer = Timer()
    
    private lazy var textFieldsArray = [self.otpText1,self.otpText2,self.otpText3,self.otpText4,self.otpText5,self.otpText6]
    
    private let auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("getVerifyCode", getVerifyCode ?? "")
        print("User Mobile Numb : ", userMobileNumber ?? "")
        mobileNumberLabel.text = userMobileNumber ?? ""
        reserndOTPButton.setTitle("Resend OTP", for: .normal)
        reserndOTPButton.setTitleColor(.buttonBackgroundColor, for:.normal)
        self.initialLoads()
        dropShadow(loginButton)
        otpText1.delegate = self
        otpText2.delegate = self
        otpText3.delegate = self
        otpText4.delegate = self
        otpText5.delegate = self
        otpText6.delegate = self
        
        otpText1.textContentType = .oneTimeCode
        
//        self.otpText1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        self.otpText1.becomeFirstResponder()
        
        otpText1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpText2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpText3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpText4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpText5.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpText6.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
    }
    
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        if #available(iOS 12.0, *) {
//            if textField.textContentType == UITextContentType.oneTimeCode{
//                //here split the text to your four text fields
//                if otpCode == getOTP, otpCode.count > 3{
//                    otpText1.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 0)])
//                    otpText2.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)])
//                    otpText3.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)])
//                    otpText4.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)])
//                    otpText5.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 4)])
//                    otpText6.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 5)])
//                }
//            }
//         }
//      }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    print(" Reachable via wifir")
                } else {
                    print("Reachable via Cellular")
                }
                self.noInternetErrorPopupHide()
            }
            self.reachability.whenUnreachable = { _ in
                print("Not reachable")
                self.noInternetErrorPopupShow("No Internet Connection")
            }
            
            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    }
    
    deinit{
        reachability.stopNotifier()
    }
    
    private func initialLoads(){
        self.otp.removeAll()
        textFieldsArray.forEach { (textField) in
            textField?.contentMode = .center
            textField?.layer.shadowColor = UIColor.black.cgColor
            textField?.layer.masksToBounds = false
            textField?.layer.shadowOpacity = 0.5
            textField?.layer.shadowOffset = CGSize(width: -1, height: 1)
            textField?.layer.shadowRadius = 1
        }
        otpText1.becomeFirstResponder()
        
        otpText1.font =  UIFont.fontStyle(14, .medium)
        otpText2.font =  UIFont.fontStyle(14, .medium)
        otpText3.font =  UIFont.fontStyle(14, .medium)
        otpText4.font =  UIFont.fontStyle(14, .medium)
        otpText5.font =  UIFont.fontStyle(14, .medium)
        otpText6.font =  UIFont.fontStyle(14, .medium)
        
        enterNumberLabel.font =  UIFont.fontStyle(17, .medium)
        mobileNumberLabel.font =  UIFont.fontStyle(17, .medium)
        
        reserndOTPButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
        loginButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case otpText1:
                otpText2.becomeFirstResponder()
            case otpText2:
                otpText3.becomeFirstResponder()
            case otpText3:
                otpText4.becomeFirstResponder()
            case otpText4:
                otpText5.becomeFirstResponder()
            case otpText5:
                otpText6.becomeFirstResponder()
            case otpText6:
                otpText6.resignFirstResponder()
            default:
                break
            }
        }
        else if  text?.count == 0 {
            switch textField{
            case otpText6:
                otpText5.becomeFirstResponder()
            case otpText5:
                otpText4.becomeFirstResponder()
            case otpText4:
                otpText3.becomeFirstResponder()
            case otpText3:
                otpText2.becomeFirstResponder()
            case otpText2:
                otpText1.becomeFirstResponder()
            case otpText1:
                otpText1.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func resendOTPButtonPressed(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        reserndOTPButton.isEnabled = false
        loginButton.isEnabled = false
    }
    
    @objc func timerAction() {
        counter += 1
        reserndOTPButton.setTitle("Resend otp in \(counter)", for: .normal)
        
        if counter == 6 {
            
            timer.invalidate()
            reserndOTPButton.isEnabled = true
            counter = 0
            self.reserndOTPButton.setTitle("Resend OTP", for: .normal)
            self.reserndOTPButton.tintColor = .blue
            AuthManager.shared.startAuth(phoneNumber: self.userMobileNumber!){[weak self] success in
                
                self?.hideIndicator()
                
                print("OTP resend successfully")
                self?.view.makeToast(ErrorMessage.list.otpsendsuccessfully)
                self?.loginButton.isEnabled = true
                guard success
                else  {
                    self?.view.makeToast(ErrorMessage.list.numberBlock)
                    print("Numb block")
                    return
                    
                }
            }
        }
    }
   
    public func verifyCode(smsCode :String, completion: @escaping(Bool) -> Void){
        guard let verificationId = getVerifyCode else{
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
                
                self.roles = result?.claims["Roles"] as? [String] ?? []
                print("Roles : \(self.roles)")
                UserDefaults.standard.setValue(self.roles, forKey: "Roles")
                print(UserDefaults.standard.stringArray(forKey: "Roles") ?? [""])
                rolename = UserDefaults.standard.string(forKey: "Roles") ?? ""
                print("RoleName : ", rolename)
                
                if(self.roles.isEmpty){
                    let storyboard = UIStoryboard(name: "User", bundle: nil)
                    let loginVC = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                    navigationController?.pushViewController(loginVC, animated: true)
                }else{
                    rolename = self.roles[0]
                    print("Role Name : ", rolename)
                    if(rolename != "USER"){
                        print("Not register as user")
                        UserDefaults.standard.setValue(false, forKey: "status")
                        let storyboard = UIStoryboard(name: "User", bundle: nil)
                        let loginVC = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                        navigationController?.pushViewController(loginVC, animated: true)
                    }
                    else  if(rolename == "USER"){
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginVC = storyboard.instantiateViewController(identifier: "GoToHome") as! HomeViewController
                        navigationController?.pushViewController(loginVC, animated: true)
                    }
                }
            })
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        otp.removeAll()
        
        guard let otp1 = otpText1.text, !otp1.isEmpty else {
            customErrorPopup("Please enter OTP")
            return
        }
        
        guard let otp2 = otpText2.text, !otp2.isEmpty else {
            customErrorPopup("Please enter OTP")
            return
        }
        
        guard let otp3 = otpText3.text, !otp3.isEmpty else {
            customErrorPopup("Please enter OTP")
            return
        }
        
        guard let otp4 = otpText4.text, !otp4.isEmpty else {
            customErrorPopup("Please enter OTP")
            return
        }
        
        guard let otp5 = otpText5.text, !otp5.isEmpty else {
            customErrorPopup("Please enter OTP")
            return
        }
        
        guard let otp6 = otpText6.text, !otp6.isEmpty else {
            customErrorPopup("Please enter OTP")
            return
        }
        
        otp.append(otpText1.text ?? "")
        otp.append(otpText2.text ?? "")
        otp.append(otpText3.text ?? "" )
        otp.append(otpText4.text ?? "")
        otp.append(otpText5.text ?? "")
        otp.append(otpText6.text ?? "")
        print(otp.joined())
        
        self.userEnterdOtp = otp.joined()
        let checkOtp: String = self.userEnterdOtp
        print("User Enter OTP : \(self.userEnterdOtp)")
        
        if userEnterdOtp == "" {
            print("Please enter otp")
            customErrorPopup("Please enter otp")
        } else if userEnterdOtp.count < 6 {
            customErrorPopup("Please correct otp")
        } else {
            
            self.showIndicator(withTitle: "Loading", and: "Please Wait")
            verifyCode(smsCode: checkOtp){ success in
                guard success else {
                    self.hideIndicator()
                    print("Wrong OTP")
                    self.view.makeToast(ErrorMessage.list.wrongOTP)
                    return
                }
                UserDefaults.standard.setValue(true, forKey: "status")
                print("Code Matches")    
            }
        }
    }
}

