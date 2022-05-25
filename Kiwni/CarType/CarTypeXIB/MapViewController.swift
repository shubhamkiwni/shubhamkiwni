//
//  MapViewController.swift
//  Kiwni
//
//  Created by Shubham Shinde on 19/04/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.isUserInteractionEnabled = false

    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        print("Map back button is work")
        
        navigationController?.popToRootViewController(animated: true)
    }

}
