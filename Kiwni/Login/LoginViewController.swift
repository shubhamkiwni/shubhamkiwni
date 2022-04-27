//
//  LoginViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 31/01/22.
//

import UIKit
import Reachability

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var mobileNumTextField: UITextField!
    @IBOutlet weak var byContinuingLabel: UILabel!
    @IBOutlet weak var termsConditionButton: UIButton!
    @IBOutlet weak var welconToKiwniLabel: UILabel!
    var myMutableString = NSMutableAttributedString()
    var myString:NSString = "Welcome to KIWNI"
    let reachability = try! Reachability()

    override func viewDidLoad() {
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Zapf Dingbats", size: 24.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location:11,length:5))
           // set label Attribute
           welconToKiwniLabel.attributedText = myMutableString
        super.viewDidLoad()
        
        mobileNumTextField.delegate = self
        mobileNumTextField.becomeFirstResponder()
        
        navigationController?.isNavigationBarHidden = true
        confirmButton.layer.cornerRadius = 10.0
        mobileNumTextField.layer.cornerRadius = 10.0
        
        confirmButton.layer.masksToBounds = false
        confirmButton.layer.shadowColor = UIColor.black.cgColor
        confirmButton.layer.shadowOpacity = 0.5
        confirmButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        confirmButton.layer.shadowRadius = 1
        
        mobileNumTextField.layer.masksToBounds = false
        mobileNumTextField.layer.shadowColor = UIColor.black.cgColor
        mobileNumTextField.layer.shadowOpacity = 0.5
        mobileNumTextField.layer.shadowOffset = CGSize(width: -1, height: 1)
        mobileNumTextField.layer.shadowRadius = 1
        
        mobileNumTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
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
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 10 {
            mobileNumTextField.resignFirstResponder()
        }
        print("Mobile Num: ", mobileNumTextField.text ?? "")
        
        
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {       
        guard  let phonenumber = mobileNumTextField.text else {return}
        if phonenumber == "" {
            customErrorPopup("Please enter mobile")
        } else if  phonenumber.count < 10 || phonenumber.count > 10 {
            customErrorPopup("Please enter 10 digit number")
        } else {
            let number = "+91\(phonenumber)"
            print("number : ", number)
           
            self.showIndicator(withTitle: "Loading", and: "Please Wait")
            
            AuthManager.shared.startAuth(phoneNumber: number){[weak self] success in
                
                self?.hideIndicator()
                
                guard success
                        
                else  {
                    
                    self?.view.makeToast(ErrorMessage.list.numberBlock)
                    self?.mobileNumTextField.text = ""
                    print("Numb block")
                    return
                    
                }
                print("Got verification code")
                let mainStoryboard = UIStoryboard(name: "User", bundle: nil)
                let otpVc = mainStoryboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                otpVc.userMobileNumber = number
                self?.navigationController?.pushViewController(otpVc, animated: true)
                
            }
        }
    }
    
    
}
