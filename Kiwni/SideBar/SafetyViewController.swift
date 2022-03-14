//
//  SafetyViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 04/02/22.
//

import UIKit

class SafetyViewController: UIViewController {

    
    @IBOutlet weak var safetyView: UIView!
    @IBOutlet weak var safetyLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var hotToAlertLabel: UILabel!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var Label5: UILabel!
    @IBOutlet weak var tryLaterButton: UIButton!
    @IBOutlet weak var alertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tryLaterButton.layer.borderWidth = 1.0
        tryLaterButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        let hvc = navigationController?.viewControllers[2] as! HomeViewController
        navigationController?.popToViewController(hvc, animated: true)
    }
    
    @IBAction func tryLaterButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func alertButtonPressed(_ sender: UIButton) {
        
        let alertVc = storyboard?.instantiateViewController(withIdentifier: "UpdateAlertDetailViewController") as! UpdateAlertDetailViewController
        self.navigationController?.pushViewController(alertVc, animated: true)
        
    }
    
}
