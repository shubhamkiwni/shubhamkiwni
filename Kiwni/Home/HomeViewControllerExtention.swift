//
//  HomeViewControllerExtention.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 02/02/22.
//

import Foundation
import UIKit


extension HomeViewController {
    
    func design(_ view: UIView) {
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 1
    }
    
    func buttonDesign(_ button: UIButton, radius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
        button.layer.cornerRadius = radius
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor
    }
    
    func shareApp() {
        if let urlStr = NSURL(string: "https://apps.apple.com/us/app/idxxxxxxxx?ls=1&mt=8") {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = self.view
                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                }
            }

            self.present(activityVC, animated: true, completion: nil)
        }
    }
}
