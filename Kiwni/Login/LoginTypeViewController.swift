//
//  LoginTypeViewController.swift
//  Kiwni
//
//  Created by Shubham Shinde on 28/04/22.
//

import UIKit

class LoginTypeViewController: UIViewController {

    
    @IBOutlet weak var kiwniLogoImageView: UIImageView!
    @IBOutlet weak var welcomeToKiwniImageView: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropShadow(signInButton)
        dropShadow(signUpButton)
    }

    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
}
