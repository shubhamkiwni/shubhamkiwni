//
//  FAQViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 03/02/22.
//

import UIKit

class FAQViewController: UIViewController {

    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var faqLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
