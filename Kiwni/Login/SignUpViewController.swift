//
//  SignUpViewController.swift
//  Kiwni
//
//  Created by Shubham Shinde on 28/04/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var mobileNoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileNoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setTitle("", for: .normal)
        dropShadow(registerButton)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        let password = passwordTextField.text ?? ""
        if firstNameTextField.text?.isAlphabets == false {
            customErrorPopup("Please enter only characters")
        } else if lastNameTextField.text?.isAlphabets == false {
            customErrorPopup("Please enter only characters")
        } else if mobileNoTextField.text?.isPhoneNumber == false {
            customErrorPopup("Please enter correct mobile no")
        } else if emailTextField.text?.isEmail == false {
            customErrorPopup("Please enter correct email address")
        } else if password.count < 8 || password.count > 8 {
            customErrorPopup("Please enter only 8 digit password")
        } else {
            let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func googleButtonPressed(_ sender: UIButton) {
    }
}
