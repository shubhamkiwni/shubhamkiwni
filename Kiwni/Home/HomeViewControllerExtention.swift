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
    
    func goToSetting(){
        
       
        
        goToSettingView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        goToSettingView.backgroundColor = .white
        goToSettingView.center = self.view.center
        view.addSubview(goToSettingView)
        print(goToSettingView.frame.origin.x, goToSettingView.frame.origin.y)
        
        myImage.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 280)
        myImage.backgroundColor = .green
        goToSettingView.addSubview(myImage)
        myImage.image = UIImage(named: "Location Permission")
        
        myLabel.frame = CGRect.init(x: 15, y: myImage.frame.height + 20, width: UIScreen.main.bounds.width, height: 20)
        goToSettingView.addSubview(myLabel)
        myLabel.text = "Location Permission Required"
        myLabel.textColor = .black
        myLabel.font = UIFont.fontStyle(15, .regular)
        
        myLabel2.frame = CGRect.init(x: 15, y: myLabel.frame.origin.y + 50, width: UIScreen.main.bounds.width, height: 50)
        goToSettingView.addSubview(myLabel2)
        myLabel2.text = "For providing Kiwni services need to enable location services."
        myLabel2.lineBreakMode = NSLineBreakMode.byWordWrapping
        myLabel2.numberOfLines = 0
        myLabel.textColor = .black
        myLabel2.font = UIFont.fontStyle(15, .regular)
        
        goToSettingButton.frame = CGRect.init(x: 15, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 30, height: 40)
        goToSettingButton.backgroundColor = UIColor.buttonBackgroundColor
        goToSettingView.addSubview(goToSettingButton)
        goToSettingButton.layer.cornerRadius = 10
        goToSettingButton.setTitleColor(.white, for: .normal)
        goToSettingButton.setTitle("Go To Setting", for: .normal)
        goToSettingButton.titleLabel?.font = UIFont.fontStyle(15, .regular)
        
        goToSettingButton.addTarget(self, action: #selector(gotoSettingButtonClicked), for: .touchUpInside)
    }
}
