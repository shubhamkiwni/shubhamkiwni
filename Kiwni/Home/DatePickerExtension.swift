//
//  DatePicker.swift
//  DatePickerDemo
//
//  Created by Shubham Shinde on 11/03/22.
//

import Foundation
import UIKit

extension HomeViewController {
    func datePickerFunction() {
        newDatePicker.center = self.view.center
        newDatePicker.preferredDatePickerStyle = .inline
        newDatePicker.datePickerMode = .date
        // Posiiton date picket within a view
        newDatePicker.frame = CGRect.init(x: 0, y: 0, width: 350, height: 300)
        newDatePicker.center = self.view.center
        print("Coordinate",newDatePicker.frame.origin.x, newDatePicker.frame.origin.y)
        cancelDatePickerButton.frame = CGRect.init(x: (newDatePicker.frame.origin.x), y: (newDatePicker.frame.origin.y)+300+10, width: newDatePicker.frame.width/2-5, height: 40)
        
        confirmDatePickerButton.frame = CGRect.init(x: (newDatePicker.frame.origin.x)+cancelDatePickerButton.frame.width+5, y: (newDatePicker.frame.origin.y)+300+10, width: newDatePicker.frame.width/2, height: 40)
        
        newDatePicker.tintColor = .buttonBackgroundColor
        
        cancelDatePickerButton.backgroundColor = .buttonBackgroundColor
        confirmDatePickerButton.backgroundColor = .buttonBackgroundColor
        
        cancelDatePickerButton.setTitle("Cancel", for: .normal)
        confirmDatePickerButton.setTitle("Confirm", for: .normal)
        
        cancelDatePickerButton.titleLabel?.font =  UIFont.fontStyle(15, .medium)
        confirmDatePickerButton.titleLabel?.font =  UIFont.fontStyle(15, .medium)        
        
        cancelDatePickerButton.setTitleColor(.white, for: .normal)
        confirmDatePickerButton.setTitleColor(.white, for: .normal)
        
        cancelDatePickerButton.layer.cornerRadius = 10.0
        confirmDatePickerButton.layer.cornerRadius = 10.0
        
        // Set some of UIDatePicker properties
        newDatePicker.timeZone = NSTimeZone.local
        newDatePicker.backgroundColor = UIColor.white
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.view.addSubview(newDatePicker)
        self.view.addSubview(cancelDatePickerButton)
        self.view.addSubview(confirmDatePickerButton)
        
    }
}
