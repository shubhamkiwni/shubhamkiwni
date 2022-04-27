//
//  ProfileViewController.swift
//  mySidebar2
//
//  Created by Muskan on 10/12/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import UIKit
import Reachability

class ProfileViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editProfileImageButton: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var userMobileNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userMailLabel: UILabel!
    @IBOutlet weak var emergencyContactLabel: UILabel!
    @IBOutlet weak var emergencyContactNumberLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var nameEditButton: UIButton!
    @IBOutlet weak var mobileNumberEditButton: UIButton!
    @IBOutlet weak var emailEditButton: UIButton!
    @IBOutlet weak var emergencyNumberEditButton: UIButton!
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.layer.cornerRadius = 15.0
        profileView.layer.shadowColor = UIColor.black.cgColor
        profileView.layer.shadowOpacity = 0.5
        profileView.layer.shadowOffset = CGSize(width: -1, height: 1)
        profileView.layer.shadowRadius = 1
        backButton.setTitle("", for: .normal)
        editProfileImageButton.setTitle("", for: .normal)
        nameEditButton.setTitle("", for: .normal)
        mobileNumberEditButton.setTitle("", for: .normal)
        emailEditButton.setTitle("", for: .normal)
        emergencyNumberEditButton.setTitle("", for: .normal)
        
        self.userNameLabel.text =  UserDefaults.standard.string(forKey: "displayName")
        self.userMailLabel.text = UserDefaults.standard.string(forKey: "email")
        self.userMobileNumberLabel.text = UserDefaults.standard.string(forKey: "phoneNumber")
        
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
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        
        // after user has successfully logged out
        UserDefaults.standard.setValue(false, forKey: "status")
        
       UserDefaults.standard.removeObject(forKey: "uid")
        UserDefaults.standard.removeObject(forKey: "displayName")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "phoneNumber")
        UserDefaults.standard.removeObject(forKey: "partyId")
        UserDefaults.standard.removeObject(forKey: "Roles")
        
        UserDefaults.standard.setValue(nil, forKey: "uid")
        UserDefaults.standard.setValue(nil, forKey: "displayName")
        UserDefaults.standard.setValue(nil, forKey: "email")
        UserDefaults.standard.setValue(nil, forKey: "phoneNumber")
        UserDefaults.standard.setValue(nil, forKey: "partyId")
        UserDefaults.standard.setValue(nil, forKey: "Roles")
        
       
        AuthManager.shared.logout()
        
        
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginViewController")
       navigationController?.pushViewController(loginNavController, animated: true)

    }
    
    @IBAction func editProfileImageButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func nameEditButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func mobileNumberEditButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func emailEditButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func emergencyNumberEditButtonPressed(_ sender: UIButton) {
        
    }
}
