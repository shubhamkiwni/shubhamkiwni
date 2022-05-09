//
//  UpdateAlertDetailViewController.swift
//  Kiwni
//
//  Created by Damini on 09/03/22.
//

import UIKit

class UpdateAlertDetailViewController: UIViewController {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var updateAlertLabel: UILabel!
    @IBOutlet weak var contactDetailLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cancelButton : UIButton!
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var contactDetailsView: UIView!
    @IBOutlet weak var footerStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactDetailsView.layer.cornerRadius = 10.0
        contactDetailsView.layer.borderColor = UIColor.black.cgColor
        contactDetailsView.layer.borderWidth = 1.0
    }
   
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        let inCaseVC = storyboard?.instantiateViewController(withIdentifier: "InCaseOfEmergencyViewController") as! InCaseOfEmergencyViewController
        navigationController?.pushViewController(inCaseVC, animated: true)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
