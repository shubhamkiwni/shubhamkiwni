//
//  EditProfileVC.swift
//  mySidebar2
//
//  Created by Muskan on 10/12/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userMobileNumberLabel: UILabel!
    @IBOutlet weak var userMailLabel: UILabel!
    @IBOutlet weak var safetyImageView: UIImageView!
    @IBOutlet weak var safetyPrivacyLabel: UIButton!
    @IBOutlet weak var manageAccountLabel: UILabel!
    @IBOutlet weak var twoStepVerificationLabel: UIButton!
    @IBOutlet weak var emergencyContactLabel: UIButton!
    @IBOutlet weak var rideSettingLabel: UIButton!
    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet weak var manageAccountRideLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var logOutImageView: UIImageView!
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.layer.cornerRadius = 15.0
        profileView.layer.shadowColor = UIColor.black.cgColor
        profileView.layer.shadowOpacity = 0.5
        profileView.layer.shadowOffset = CGSize(width: -1, height: 1)
        profileView.layer.shadowRadius = 1
        backButton.setTitle("", for: .normal)
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

}
