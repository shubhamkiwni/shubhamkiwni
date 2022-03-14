//
//  AboutViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 02/02/22.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        let hvc = navigationController?.viewControllers[2] as! HomeViewController
        navigationController?.popToViewController(hvc, animated: true)
    }
}
