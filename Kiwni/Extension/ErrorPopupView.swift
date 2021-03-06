//
//  ErrorPopupView.swift
//  Kiwni
//
//  Created by Shubham Shinde on 28/02/22.
//

import Foundation
import UIKit

var errorCustomView = UIView()
var errorString = UILabel()
var closeButton = UIButton()
var errorLable = UILabel()
private var viewBackground : UIView?
let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
let imageName = "Wifi Icon"
let image = UIImage(named: imageName)
let noInternetImageView = UIImageView(image: image!)

extension UIViewController {
    
    func customErrorPopup(_ errorMessage: String) {
        
        errorCustomView.frame = CGRect.init(x: 0, y: 0, width: 350, height: 167)
        errorCustomView.backgroundColor = .white
        errorCustomView.center = self.view.center
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        
        
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.view.addSubview(errorCustomView)
        
        print(errorCustomView.frame.origin.x, errorCustomView.frame.origin.y)
        
        errorString.text = errorMessage
        errorString.frame = CGRect.init(x: 0, y: 0, width: 500, height: 50)
        errorString.textColor = .black
        errorString.font = errorString.font.withSize(12)
        
        errorString.center = self.view.center
        errorString.textAlignment = . center
        self.view.addSubview(errorString)
        print(errorLable.frame.origin.x, errorLable.frame.origin.y)
        
        errorLable.text = "Error!"
        errorLable.frame = CGRect.init(x: errorCustomView.frame.origin.x + 60, y: errorCustomView.frame.origin.y + 40, width: 200, height: 30)
        errorLable.textColor = .black
        errorLable.font = errorString.font.withSize(16)
        errorLable.textAlignment = . center
        self.view.addSubview(errorLable)
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.frame = CGRect.init(x: errorCustomView.frame.origin.x + 240, y: errorCustomView.frame.origin.y + 130, width: 100, height: 20)
        closeButton.backgroundColor = .lightGray
        closeButton.layer.cornerRadius = 5.0
        self.view.addSubview(closeButton)
        
        print(errorCustomView.frame.width, errorCustomView.frame.height)
        
        closeButton.addTarget(self, action: #selector(popUpCancelButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func popUpCancelButtonPressed() {
        errorCustomView.removeFromSuperview()
        errorLable.removeFromSuperview()
        errorString.removeFromSuperview()
        closeButton.removeFromSuperview()
        blurEffectView.removeFromSuperview()
    }
}

extension UIViewController {
    func noInternetErrorPopupShow(_ errorMessage: String) {
        errorCustomView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        errorCustomView.backgroundColor = .white
        self.view.addSubview(errorCustomView)
        
        
        noInternetImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        noInternetImageView.center = self.view.center
        view.addSubview(noInternetImageView)
        print(noInternetImageView.frame.origin.x, noInternetImageView.frame.origin.y)
        
        errorString.text = errorMessage
        errorString.frame = CGRect.init(x: noInternetImageView.frame.origin.x - 60, y: noInternetImageView.frame.origin.y + 60, width: 200, height: 30)
        errorString.textColor = .black
        errorString.font = errorString.font.withSize(18)
//        errorString.center = self.view.center
        errorString.textAlignment = . center
        self.view.addSubview(errorString)
        print(errorString.frame.origin.x, errorString.frame.origin.y)
        
    }
    
    func noInternetErrorPopupHide() {
        errorCustomView.removeFromSuperview()
        errorString.removeFromSuperview()
        noInternetImageView.removeFromSuperview()
    }
    
    func dropShadow(_ button: UIButton){
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowRadius = 2.0
        button.layer.cornerRadius = 10
        button.backgroundColor = .buttonBackgroundColor
    }
    
    func uiViewDesign(_ view: UIStackView){
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 2.0
        view.layer.cornerRadius = 10
    }
    
    func uiViewDesign2(_ view: UIView){
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 2.0
    }
    
}

extension UITextField {
    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }

    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }

    func addBottomBorderWithColor(color: UIColor, width: CGFloat, frameWidth: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frameWidth, height: width)
        self.layer.addSublayer(border)
    }

    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
}
