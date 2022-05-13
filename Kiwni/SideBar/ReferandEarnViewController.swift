//
//  ReferandEarnViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 03/02/22.
//

import UIKit

class ReferandEarnViewController: UIViewController {

    @IBOutlet weak var referView: UIView!
    @IBOutlet weak var referLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var inviteLabel: UILabel!
    @IBOutlet weak var youInviteLabel: UILabel!
    @IBOutlet weak var earnView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var earnLabel: UILabel!
    @IBOutlet weak var referalView: UIView!
    @IBOutlet weak var yourReferalCodeLabel: UILabel!
    @IBOutlet weak var referalCodeLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var shareCodeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design(earnView)
        design(referalView)
//        buttonDesign(shareCodeButton)
        dropShadow(shareCodeButton)
    }
    
    @IBAction func copyButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareCodeButtonPressed(_ sender: UIButton) {
    }
    
    func design(_ view: UIView) {
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 1
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor
    }
    
//    func buttonDesign(_ button: UIButton) {
//        button.layer.cornerRadius = 10.0
//        button.layer.masksToBounds = false
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOpacity = 0.5
//        button.layer.shadowOffset = CGSize(width: -1, height: 1)
//        button.layer.shadowRadius = 1
//    }
}
