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
        
        // Set some of UIDatePicker properties
        newDatePicker.timeZone = NSTimeZone.local
        newDatePicker.backgroundColor = UIColor.white
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.view.addSubview(newDatePicker)
    }
}
