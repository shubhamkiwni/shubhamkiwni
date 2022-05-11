//
//  ProfileViewController.swift
//  mySidebar2
//
//  Created by Muskan on 10/12/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import UIKit
import Reachability

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editProfileImageButton: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var userMobileNumberTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var emergencyContactLabel: UILabel!
    @IBOutlet weak var emergencyContactNumberTextField: UITextField!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var nameEditButton: UIButton!
    @IBOutlet weak var emailEditButton: UIButton!
    @IBOutlet weak var emergencyNumberEditButton: UIButton!
    let reachability = try! Reachability()
    @IBOutlet weak var profileImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage()
        
        imagePicker.allowsEditing = true
        profileImageView.layer.cornerRadius = 50
        profileView.layer.cornerRadius = 15.0
        profileView.layer.shadowColor = UIColor.black.cgColor
        profileView.layer.shadowOpacity = 0.5
        profileView.layer.shadowOffset = CGSize(width: -1, height: 1)
        profileView.layer.shadowRadius = 1
        backButton.setTitle("", for: .normal)
        editProfileImageButton.setTitle("", for: .normal)
        nameEditButton.setTitle("", for: .normal)
        emailEditButton.setTitle("", for: .normal)
        emergencyNumberEditButton.setTitle("", for: .normal)
        
        self.userNameTextField.text =  UserDefaults.standard.string(forKey: "displayName")
        self.userEmailTextField.text = UserDefaults.standard.string(forKey: "email")
        self.userMobileNumberTextField.text = UserDefaults.standard.string(forKey: "phoneNumber")
        
        nameLabel.font = UIFont.fontStyle(13, .medium)
        mobileNumberLabel.font = UIFont.fontStyle(13, .medium)
        emailLabel.font = UIFont.fontStyle(13, .medium)
        emergencyContactLabel.font = UIFont.fontStyle(13, .medium)
        
        userNameTextField.font = UIFont.fontStyle(15, .medium)
        userMobileNumberTextField.font = UIFont.fontStyle(15, .medium)
        userEmailTextField.font = UIFont.fontStyle(15, .medium)
        emergencyContactNumberTextField.font = UIFont.fontStyle(15, .medium)
        
        logOutButton.titleLabel?.font = UIFont.fontStyle(15, .medium)
        
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
        print("Clicked edit profile button")
        imagePicker.delegate = self
        
        let alert = UIAlertController(title: "Profile Image", message: "Change Profile Image", preferredStyle: UIAlertController.Style.alert)
        
        
        
        alert.addAction(UIAlertAction(title: "Select From Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            else{
                print("Camera Not available")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Select From Photo Library", style: .default, handler: { (action: UIAlertAction) in
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let setImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as! UIImage
        profileImageView.image = setImage
        
        guard let data = profileImageView.image!.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "profileImage")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func loadImage() {
        guard let data = UserDefaults.standard.data(forKey: "profileImage") else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let storeimage = UIImage(data: decoded)
        profileImageView.image = storeimage
        
        
    }
    
    @IBAction func nameEditButtonPressed(_ sender: UIButton) {
        userInteractionInTextField(userNameTextField)
    }
    
    @IBAction func emailEditButtonPressed(_ sender: UIButton) {
        userInteractionInTextField(userEmailTextField)
    }
    
    @IBAction func emergencyNumberEditButtonPressed(_ sender: UIButton) {
       userInteractionInTextField(emergencyContactNumberTextField)
    }
    
    func userInteractionInTextField(_ textField: UITextField) {
        if textField.isUserInteractionEnabled == true {
            textField.isUserInteractionEnabled = false
            print("myTextField.text:",textField.text ?? "")
            textField.resignFirstResponder()
        } else {
            textField.isUserInteractionEnabled = true
            textField.becomeFirstResponder()
        }
    }
    
}
