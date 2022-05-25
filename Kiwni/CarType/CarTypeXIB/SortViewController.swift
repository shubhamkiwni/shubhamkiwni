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

        dropShadow(latestButton)
        dropShadow(popularityButton)
        dropShadow(highToLowButton)
        dropShadow(lowToHighButton)
        
        latestButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        popularityButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        highToLowButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        lowToHighButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        sortLabel.font = UIFont.fontStyle(15, .semiBold)
        
        latestButton.setTitleColor(.white, for: .normal)
        popularityButton.setTitleColor(.white, for: .normal)
        highToLowButton.setTitleColor(.white, for: .normal)
        lowToHighButton.setTitleColor(.white, for: .normal)
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

