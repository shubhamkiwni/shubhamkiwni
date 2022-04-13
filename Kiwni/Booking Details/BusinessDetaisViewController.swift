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
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        
        
        businessDetailsView.layer.cornerRadius = 10.0
        businessDetailsView.layer.borderWidth = 1.0
        businessDetailsView.layer.borderColor = UIColor.black.cgColor
        
        businessDetailsView.layer.borderWidth = 1.0
        businessDetailsView.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        UserDefaults.standard.setValue(companyNameTextField.text, forKey: "companyName")
        UserDefaults.standard.setValue(companyEmailsTextField.text, forKey: "companyEmail")
        UserDefaults.standard.setValue(phoneNoTextField.text, forKey: "companyPhoneNo")
        print(companyNameTextField.text, companyEmailsTextField.text, phoneNoTextField.text)
        
        navigationController?.popViewController(animated: true)
    }
}
