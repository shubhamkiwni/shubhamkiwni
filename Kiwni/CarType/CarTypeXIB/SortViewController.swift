//
//  SortViewController.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 21/02/22.
//

import UIKit

class SortViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var latestButton: UIButton!
    @IBOutlet weak var popularityButton: UIButton!
    @IBOutlet weak var highToLowButton: UIButton!
    @IBOutlet weak var lowToHighButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        latestButton.layer.cornerRadius = 10.0
        latestButton.layer.masksToBounds = false
        latestButton.layer.shadowColor = UIColor.black.cgColor
        latestButton.layer.shadowOpacity = 0.5
        latestButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        latestButton.layer.shadowRadius = 1
        
        popularityButton.layer.cornerRadius = 10.0
        popularityButton.layer.masksToBounds = false
        popularityButton.layer.shadowColor = UIColor.black.cgColor
        popularityButton.layer.shadowOpacity = 0.5
        popularityButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        popularityButton.layer.shadowRadius = 1
        
        highToLowButton.layer.cornerRadius = 10.0
        highToLowButton.layer.masksToBounds = false
        highToLowButton.layer.shadowColor = UIColor.black.cgColor
        highToLowButton.layer.shadowOpacity = 0.5
        highToLowButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        highToLowButton.layer.shadowRadius = 1
        
        lowToHighButton.layer.cornerRadius = 10.0
        lowToHighButton.layer.masksToBounds = false
        lowToHighButton.layer.shadowColor = UIColor.black.cgColor
        lowToHighButton.layer.shadowOpacity = 0.5
        lowToHighButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        lowToHighButton.layer.shadowRadius = 1
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
//        let hvc = navigationController?.viewControllers[4] as! CarsViewController
//        navigationController?.popToViewController(hvc, animated: true)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func latestButtonPressed(_ sender: UIButton) {
        let rvc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        rvc.sortingLabel = "Latest"
        navigationController?.pushViewController(rvc, animated: true)
    }
    
    @IBAction func popularityButtonPressed(_ sender: UIButton) {
        let rvc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        rvc.sortingLabel = "Popularity"
        navigationController?.pushViewController(rvc, animated: true)
    }
    
    @IBAction func highToLowButtonPressed(_ sender: UIButton) {
        let rvc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        rvc.sortingLabel = "High To Low"
        navigationController?.pushViewController(rvc, animated: true)
    }
    
    @IBAction func lowToHighButtonPressed(_ sender: UIButton) {
        let rvc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        rvc.sortingLabel = "Low To High"
        navigationController?.pushViewController(rvc, animated: true)
    }
}

