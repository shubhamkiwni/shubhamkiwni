//
//  DropLocationOnSearchView.swift
//  Kiwni
//
//  Created by Admin on 19/01/22.
//

import UIKit

protocol dropOnlocateSearchdelegate{
   
    func dropLocateUserOnMap()
}


class DropLocationOnSearchView: UIView {

//    let nibName = "DropLocationOnSearchView"
    var delegate : dropOnlocateSearchdelegate!

    @IBOutlet weak var dropLocateOnMap: UIButton!
    
    internal override func awakeFromNib() {
        dropLocateOnMap.backgroundColor = .buttonBackgroundColor        
    }
    

    @IBAction fileprivate func droplocateOnMapAction(sender: UIButton)
    {
        LocationDetect.shareInstance.acController.dismiss(animated: true) {
                    print("click")
            
            if let de = self.delegate
            {
                de.dropLocateUserOnMap()
            }
        }
        
        
        
    }
    
}
