//
//  PaymentModeViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 15/02/22.
//

import UIKit

class PaymentModeViewController: UIViewController {
    
    @IBOutlet var paymentModeButton: [UIButton]!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var paymentModeView: UIView!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentModeView.layer.cornerRadius = 10.0
        paymentModeView.layer.borderColor = UIColor.black.cgColor
        paymentModeView.layer.borderWidth = 1.0
        
        payButton.layer.cornerRadius = 5
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)

    }
    @IBAction func payButtonClicked(_ sender: UIButton) {
        dismiss(animated: true) {
//            let hvc = self.navigationController?.viewControllers[2] as! HomeViewController
//            self.navigationController?.popToViewController(hvc, animated: true)
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThankYouViewController") as! ThankYouViewController
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
    }
    
    @IBAction func paymentModeButtonPressed(_ sender: UIButton) {
        for button in paymentModeButton {
            if button.tag == sender.tag {
                button.setImage(UIImage(named: "Check"), for: .normal)
//                buttonTag = sender.tag
            } else {
                button.setImage(UIImage(named: "Uncheck"), for: .normal)
            }
        }
    }
    
}
