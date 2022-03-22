//
//  TimePicker.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 16/02/22.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func setTimeToPicker(){
        timeFormatter.dateFormat = "hh:mm a"
        //timeFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
        let calendar = Calendar.current
        newdate = calendar.date(byAdding: .hour, value: 1, to: currentDate)!
        print("Added hours Date :", newdate)
        
//        pickUpOnDatePicker.minimumDate = newdate
//        returnByDatePicker.minimumDate = newdate
        
        let currentTime = timeFormatter.string(from: newdate.nextHalfHour)
        print("Current Time : ", currentTime)
        self.arrSlots = getTimeIntervals(fromTime:currentTime)
        print("Array from setTimePicker:", self.arrSlots)
        
//        timeFormatter.dateFormat = "yyyy-MM-dd"
//        timeFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
//        strDate = timeFormatter.string(from: newdate)
//        print("StartDate : ", strDate ?? "")

       
        // print(Date())
        // print(currentTime)
       
        strTime = timeFormatter.string(from: newdate)
        print("Time : ", strTime ?? "")
//        timePickerButton.setTitle(strTime, for: .normal)
//        pickUpOnTimeLable.text = strTime
        pickUpOnTimePickerButton.setTitle(strTime, for: .normal)
      
        
        
        timeFormatter.dateFormat = "E, MMM d, yyyy"
        currentDateString = timeFormatter.string(from: newdate)
        print("currentDateString : ",currentDateString ?? "")
        
        
//        strDate = currentDateString
    
    }
    
    func getTimeIntervals(fromTime currentTime: String, withGap gap: interval = .minutes30) -> [String] {
      var arrSlots: [String] = []
      let initialTime = currentTime

      let timeFormatter = DateFormatter()
      timeFormatter.dateFormat = "hh:mm a"

      let startTime = timeFormatter.date(from: initialTime)!
      // print(startTime)

      timeFormatter.dateFormat = "dd"
      let startDay = Int(timeFormatter.string(from: startTime))
      // print(startDay!)

      timeFormatter.dateFormat = "hh:mm a"
      
      var i = 0
      while true {
        let nextTime = startTime.addingTimeInterval(TimeInterval(i*gap.rawValue*60))
        
        timeFormatter.dateFormat = "hh:mm a"
        let strNextTime = timeFormatter.string(from: nextTime)

        // print(nextTime)

        timeFormatter.dateFormat = "dd"
        let nextDay = Int(timeFormatter.string(from: nextTime))
        // print(nextDay!)
        
        if nextDay! > startDay! {
           
            break;
        }
        
      
          
//        if(currentDateString == myPickerDateString){
//            if(strNextTime == "12:00 AM"){
//                break;
//            }
//        }
        

        arrSlots.append(strNextTime)
        
        // print(strNextTime)
       
        


        i += 1
      }

      return arrSlots
    }
    
}
