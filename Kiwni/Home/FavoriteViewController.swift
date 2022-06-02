//
//  FavoriteViewController.swift
//  Kiwni
//
//  Created by Shubham Shinde on 17/05/22.
//

import UIKit

class FavoriteViewController: UIViewController {

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
    var getAddress = String()
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
    }
    

    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func homeRadioButtonClicked(_ sender: UIButton) {
        officeRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        otherRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        homeRadioButton.setImage(UIImage(named: "Check"), for: .normal)
    }
    
    @IBAction func officeRadioButtonClicked(_ sender: UIButton) {
        officeRadioButton.setImage(UIImage(named: "Check"), for: .normal)
        otherRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        homeRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
    }
    
    @IBAction func otherRadioButtonClicked(_ sender: UIButton) {
        officeRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
        otherRadioButton.setImage(UIImage(named: "Check"), for: .normal)
        homeRadioButton.setImage(UIImage(named: "Uncheck"), for: .normal)
    }
    
    
}
