//
//  PickupLocationOnSearchView.swift
//  Kiwni
//
//  Created by Admin on 19/01/22.
//

import UIKit

protocol pickupOnlocateSearchdelegate{
    func pickupGetCurrentLocation()
    func pickupLocateUserOnMap()
}

class PickupLocationOnSearchView: UIView {
//    let nibName = "PickupLocationOnSearchView"
    var delegate : pickupOnlocateSearchdelegate!

    @IBOutlet weak var pickupCurrentLocation: UIButton!
    @IBOutlet weak var pickupLocateOnMap: UIButton!
    
    @IBAction fileprivate func pickupcurrentLocationAction(_ sender: UIButton) {
    
        LocationDetect.shareInstance.acController.dismiss(animated: true) { [self] in
            print("currentLocation button clicked")
            
            
            if let d = delegate
            {
                d.pickupGetCurrentLocation()
            }
          
        }
        
    }
    
    @IBAction fileprivate func pickuplocateOnMapAction(_ sender: UIButton) {
        LocationDetect.shareInstance.acController.dismiss(animated: true) {
            print("locateOnMapAction button clicked")
           
            if let d = self.delegate
            {
                d.pickupLocateUserOnMap()
            }
        }
       
    }
}

