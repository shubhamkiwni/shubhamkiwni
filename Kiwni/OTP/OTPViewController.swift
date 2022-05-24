//
//  OTPViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 31/01/22.
//

import UIKit
import Reachability

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
    
    private lazy var textFieldsArray = [self.otpText1,self.otpText2,self.otpText3,self.otpText4,self.otpText5,self.otpText6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("User Mobile Numb : ", userMobileNumber ?? "")
        mobileNumberLabel.text = userMobileNumber ?? ""
        self.initialLoads()
        
        /* otpText1.becomeFirstResponder()
         
         otpText1.layer.masksToBounds = false
         otpText1.layer.shadowColor = UIColor.black.cgColor
         otpText1.layer.shadowOpacity = 0.5
         otpText1.layer.shadowOffset = CGSize(width: -1, height: 1)
         otpText1.layer.shadowRadius = 1
         
         otpText2.layer.masksToBounds = false
         otpText2.layer.shadowColor = UIColor.black.cgColor
         otpText2.layer.shadowOpacity = 0.5
         otpText2.layer.shadowOffset = CGSize(width: -1, height: 1)
         otpText2.layer.shadowRadius = 1
         
         otpText3.layer.masksToBounds = false
         otpText3.layer.shadowColor = UIColor.black.cgColor
         otpText3.layer.shadowOpacity = 0.5
         otpText3.layer.shadowOffset = CGSize(width: -1, height: 1)
         otpText3.layer.shadowRadius = 1
         
         otpText4.layer.masksToBounds = false
         otpText4.layer.shadowColor = UIColor.black.cgColor
         otpText4.layer.shadowOpacity = 0.5
         otpText4.layer.shadowOffset = CGSize(width: -1, height: 1)
         otpText4.layer.shadowRadius = 1
         
         otpText5.layer.masksToBounds = false
         otpText5.layer.shadowColor = UIColor.black.cgColor
         otpText5.layer.shadowOpacity = 0.5
         otpText5.layer.shadowOffset = CGSize(width: -1, height: 1)
         otpText5.layer.shadowRadius = 1
         
         otpText6.layer.masksToBounds = false
         otpText6.layer.shadowColor = UIColor.black.cgColor
         otpText6.layer.shadowOpacity = 0.5
         otpText6.layer.shadowOffset = CGSize(width: -1, height: 1)
         otpText6.layer.shadowRadius = 1
         */
        
        
        //        loginButton.layer.cornerRadius = 10.0
        //        loginButton.layer.masksToBounds = false
        //        loginButton.layer.shadowColor = UIColor.black.cgColor
        //        loginButton.layer.shadowOpacity = 0.5
        //        loginButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        //        loginButton.layer.shadowRadius = 1
        
        dropShadow(loginButton)
        
        
        otpText1.delegate = self
        otpText2.delegate = self
        otpText3.delegate = self
        otpText4.delegate = self
        otpText5.delegate = self
        otpText6.delegate = self
        
        otpText1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpText2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpText3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpText4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpText5.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpText6.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
    }
    
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
        // self.view.dismissKeyBoardonTap()
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
        print("OTP resend successfully")
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        //        let hVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        //        navigationController?.pushViewController(hVC, animated: true)
        otp.removeAll()
        
        guard let otp1 = otpText1.text, !otp1.isEmpty else {
            //            self.view.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            customErrorPopup("Please enter OTP")
            return
        }
        
        guard let otp2 = otpText2.text, !otp2.isEmpty else {
            //            self.view.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            customErrorPopup("Please enter OTP")
            return
        }
        
        guard let otp3 = otpText3.text, !otp3.isEmpty else {
            //            self.view.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            customErrorPopup("Please enter OTP")
            return
        }
        
        guard let otp4 = otpText4.text, !otp4.isEmpty else {
            //           self.view.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            customErrorPopup("Please enter OTP")
            return
        }
        
        guard let otp5 = otpText5.text, !otp5.isEmpty else {
            //           self.view.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            customErrorPopup("Please enter OTP")
            return
        }
        
        guard let otp6 = otpText6.text, !otp6.isEmpty else {
            //           self.view.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
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
            AuthManager.shared.verifyCode(smsCode: checkOtp){ success in
                guard success else {
                    self.hideIndicator()
                    print("Wrong OTP")
                    self.view.makeToast(ErrorMessage.list.wrongOTP)
                    return
                }
                UserDefaults.standard.setValue(true, forKey: "status")
                print("Code Matches")
                let homeVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoToHome") as! HomeViewController
                self.navigationController?.pushViewController(homeVc, animated: true)
                
            }
        }
    }
}

