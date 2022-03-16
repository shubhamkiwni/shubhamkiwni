//
//  LoginViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 31/01/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var mobileNumTextField: UITextField!
    @IBOutlet weak var byContinuingLabel: UILabel!
    @IBOutlet weak var termsConditionButton: UIButton!
    
    override func viewDidLoad() {
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
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 10 {
            mobileNumTextField.resignFirstResponder()
        }
        print("Mobile Num: ", mobileNumTextField.text ?? "")
        
      
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
//        let otpVC = storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.OTPViewController) as! OTPViewController
//        navigationController?.pushViewController(otpVC, animated: true)
//
//        guard  let phonenumber = mobileNumTextField.text else {return}
//        let number = "+91\(phonenumber)"
//        print("number : ", number)
//        if (NetworkMonitor.share.isConnected == false){
//
//            self.view.makeToast(ErrorMessage.list.checkyourinternetconnectivity)
//            return
//        }
//        self.showIndicator(withTitle: "Loading", and: "Please Wait")
//
//            AuthManager.shared.startAuth(phoneNumber: number){[weak self] success in
//
//                    self?.hideIndicator()
//
//                    guard success
//
//                    else  {
//
//                        self?.view.makeToast(ErrorMessage.list.numberBlock)
//                        self?.mobileNumTextField.text = ""
//                        print("Numb block")
//                        return
//
//                    }
////                    self?.hideIndicator()
//                    print("Got verification code")
              
               
                
                let otpVC = UIStoryboard(name: "User", bundle:nil).instantiateViewController(withIdentifier: Storyboard.Ids.OTPViewController) as! OTPViewController
        self.navigationController?.pushViewController(otpVC, animated: true)
                 
//            }
    }
    
    
}
