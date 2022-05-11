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
    
    var btnView = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setTitle("", for: .normal)
        dropShadow(registerButton)
        firstNameTextField.setUnderLine()
        lastNameTextField.setUnderLine()
        mobileNoTextField.setUnderLine()
        emailTextField.setUnderLine()
        passwordTextField.setUnderLine()
        setRightViewIcon(icon: UIImage(named: "Close password")!, textfield: passwordTextField)
        
        signUpLabel.font =  UIFont.fontStyle(15, .bold)
        firstNameLabel.font =  UIFont.fontStyle(14, .medium)
        lastNameLabel.font =  UIFont.fontStyle(14, .medium)
        mobileNoLabel.font =  UIFont.fontStyle(14, .medium)
        emailLabel.font =  UIFont.fontStyle(14, .medium)
        passwordLabel.font =  UIFont.fontStyle(14, .medium)
        
        firstNameTextField.font =  UIFont.fontStyle(15, .medium)
        lastNameTextField.font =  UIFont.fontStyle(15, .medium)
        mobileNoTextField.font =  UIFont.fontStyle(15, .medium)
        emailTextField.font =  UIFont.fontStyle(15, .medium)
        passwordTextField.font =  UIFont.fontStyle(15, .medium)
        
        registerButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
        
        emailLabel.font =  UIFont.fontStyle(15, .medium)
        
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
    
    func setRightViewIcon(icon: UIImage, textfield: UITextField) {
        btnView = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        btnView.setImage(icon, for: .normal)
        btnView.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 1)
        btnView.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        textfield.rightViewMode = .always
        textfield.rightView = btnView
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        print("Eye button clicked")
        secureTextConversion(passwordTextField)
    }
    
    func secureTextConversion(_ textField: UITextField) {
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false
            btnView.setImage(UIImage(named: "password"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            btnView.setImage(UIImage(named: "Close password"), for: .normal)
        }
    }
    
}
