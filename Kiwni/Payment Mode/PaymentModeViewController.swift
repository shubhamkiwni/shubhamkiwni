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
    @IBOutlet weak var selectPaymentModeLabel: UILabel!
    @IBOutlet weak var googlePayLabel: UILabel!
    @IBOutlet weak var amazonPayLabel: UILabel!
    @IBOutlet weak var addExistingUPIIDPayLabel: UILabel!
    @IBOutlet weak var payPalLabel: UILabel!
    @IBOutlet weak var giftVocherLabel: UILabel!
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var debitCardLabel: UILabel!
    @IBOutlet weak var netBankingLabel: UILabel!
    @IBOutlet weak var noCostEMILabel: UILabel!
    @IBOutlet weak var walletsLabel: UILabel!
    @IBOutlet weak var zeroMoneyEMILabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentModeView.layer.cornerRadius = 10.0
        paymentModeView.layer.borderColor = UIColor.black.cgColor
        paymentModeView.layer.borderWidth = 1.0
        payButton.layer.cornerRadius = 5
        payButton.backgroundColor = .buttonBackgroundColor
        selectPaymentModeLabel.font = UIFont.fontStyle(17, .semiBold)
        googlePayLabel.font = UIFont.fontStyle(15, .regular)
        amazonPayLabel.font = UIFont.fontStyle(15, .regular)
        addExistingUPIIDPayLabel.font = UIFont.fontStyle(15, .regular)
        payPalLabel.font = UIFont.fontStyle(15, .regular)
        giftVocherLabel.font = UIFont.fontStyle(15, .regular)
        creditCardLabel.font = UIFont.fontStyle(15, .regular)
        debitCardLabel.font = UIFont.fontStyle(15, .regular)
        netBankingLabel.font = UIFont.fontStyle(15, .regular)
        noCostEMILabel.font = UIFont.fontStyle(15, .regular)
        walletsLabel.font = UIFont.fontStyle(15, .regular)
        zeroMoneyEMILabel.font = UIFont.fontStyle(15, .regular)
        cashLabel.font = UIFont.fontStyle(15, .regular)
        payButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)

    }
    @IBAction func payButtonClicked(_ sender: UIButton) {
        dismiss(animated: true) {            
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
