//
//  PaymentViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 02/02/22.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        let hvc = navigationController?.viewControllers[2] as! HomeViewController
        navigationController?.popToViewController(hvc, animated: true)
    }
}
