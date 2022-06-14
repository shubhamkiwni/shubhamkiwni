//
//  FavoriteViewController.swift
//  Kiwni
//
//  Created by Shubham Shinde on 17/05/22.
//

import UIKit
import GoogleMaps

class FavoriteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var favouiteView: UIView!
    @IBOutlet weak var saveFavouiteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var officeLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var homeRadioButton: UIButton!
    @IBOutlet weak var officeRadioButton: UIButton!
    @IBOutlet weak var otherRadioButton: UIButton!
    @IBOutlet weak var otherTextField: UITextField!
    var getAddress = String()
    var address = [LocationAddress]()
    var i = Int()
    var isUpdate: Bool = false
    var addressValueType = String()
    var addressCoordinate: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressLabel.text = getAddress
        favouiteView.layer.cornerRadius = 10.0
        saveFavouiteLabel.font = UIFont.fontStyle(23, .regular)
        addressLabel.font = UIFont.fontStyle(17, .regular)
        homeLabel.font = UIFont.fontStyle(17, .regular)
        officeLabel.font = UIFont.fontStyle(17, .regular)
        otherLabel.font = UIFont.fontStyle(17, .regular)
        cancelButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        saveButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        saveButton.backgroundColor = .buttonBackgroundColor
        homeRadioButton.setImage(UIImage(named: "Check"), for: .normal)
        addressValueType = "Home"
//        otherTextField.text = "Other"
        otherTextField.isHidden = true
        otherTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .valueChanged)
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        
        if otherTextField.text?.isEmpty == true {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
            addressValueType = otherTextField.text ?? ""
            saveButton.backgroundColor = .buttonBackgroundColor
        }
        print(addressValueType)
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        print(addressValueType)
        
        var getAddressTypeFromDB = [String]()
        getAddressTypeFromDB = []
        address = DataBaseHelper.shareinstance.getData()
        print(address)
        
        let dict = ["addressValue": getAddress ,
                    "addressType": addressValueType,
                    "addressLat": "\(addressCoordinate.latitude)" ,
                    "addressLong": "\(addressCoordinate.longitude)"]
        
        if address.isEmpty == false {
            for i in address {
                print("Get address type:",i.addressType ?? "Not get")
                getAddressTypeFromDB.append(i.addressType ?? "")
                print("getAddressTypeFromDB : ", getAddressTypeFromDB)
                
                for j in 0 ..< getAddressTypeFromDB.count {
                    if (getAddressTypeFromDB[j] == addressValueType) {
                        isUpdate = true
                        DataBaseHelper.shareinstance.editData(object: dict , i: j)
                    } else if getAddressTypeFromDB[j] == "Other" {
                        //                         DataBaseHelper.shareinstance.saveData(object: dict)
                        isUpdate = false
                    }
                }
            }
        }
        if isUpdate == false {
            DataBaseHelper.shareinstance.saveData(object: dict)
        }
        dismiss(animated: true)
    }
    
    @IBAction func homeRadioButtonClicked(_ sender: UIButton) {
        officeRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        otherRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        homeRadioButton.setImage(UIImage(named: "Check"), for: .normal)
        addressValueType = "Home"
        otherTextField.isHidden = true
    }
    
    @IBAction func officeRadioButtonClicked(_ sender: UIButton) {
        officeRadioButton.setImage(UIImage(named: "Check"), for: .normal)
        otherRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        homeRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        addressValueType = "Work"
        otherTextField.isHidden = true
    }
    
    @IBAction func otherRadioButtonClicked(_ sender: UIButton) {
        officeRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        otherRadioButton.setImage(UIImage(named: "Check"), for: .normal)
        homeRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        addressValueType = "Other"
        otherTextField.isHidden = false
        saveButton.isEnabled = false
        saveButton.backgroundColor = .lightGray
    }
    
    
}
