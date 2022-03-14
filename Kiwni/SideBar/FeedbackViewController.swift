//
//  FeedbackViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 03/02/22.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
