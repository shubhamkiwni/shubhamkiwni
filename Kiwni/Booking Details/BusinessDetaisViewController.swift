//
//  BusinessDetaisViewController.swift
//  Kiwni
//
//  Created by Shubham Shinde on 23/02/22.
//

import UIKit

class BusinessDetaisViewController: UIViewController {
    
    @IBOutlet weak var businessDetailsView: UIView!
    @IBOutlet weak var businessDetailsLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyEmailLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var companyEmailsTextField: UITextField!
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    var callBack: ((_ companyNameVar: String, _ companyEmailVar: String, _ companyNumberVar: String)-> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        
        
        businessDetailsView.layer.cornerRadius = 10.0
        businessDetailsView.layer.borderWidth = 1.0
        businessDetailsView.layer.borderColor = UIColor.black.cgColor
        
        businessDetailsView.layer.borderWidth = 1.0
        businessDetailsView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        if(companyEmailsTextField.text?.isEmail == false){
            customErrorPopup("Please enter valid email id")
        }
        else if(phoneNoTextField.text?.isPhoneNumber == false){
            customErrorPopup("Please enter valid mobile number")
        }
        else if companyNameTextField.text == "" || companyEmailsTextField.text == "" || phoneNoTextField.text == "" {
            customErrorPopup("Please fill all the details")
        }
        else {
            
            callBack?(companyNameTextField.text ?? "",companyEmailsTextField.text ?? "",phoneNoTextField.text ?? "")
            navigationController?.popViewController(animated: true)
        }
        
    }
}
