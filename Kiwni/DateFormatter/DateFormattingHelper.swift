//
//  DateFormattingHelper.swift
//  Kiwni
//
//  Created by Admin on 31/01/22.
//

import Foundation
struct DateFormattingHelper {

    static func strToDateTime(strDateTime: String?) -> Date? {
        if let dateTime = DateFormatter.yyyyMMdd_T_HHmmss.date(from: strDateTime ?? "") {
            return dateTime
        } else if let dateTime = DateFormatter.yyyyMMdd_T_HHmmssZ.date(from: strDateTime ?? "") {
            return dateTime
        } else if let dateTime = DateFormatter.yyyyMMdd_T_HHmmss_SSS.date(from: strDateTime ?? "") {
            return dateTime
        }else if let dateTime = DateFormatter.yyyyMMdd_T_HHmmss_SSSZ.date(from: strDateTime ?? "") {
            return dateTime
        }
        return nil
    }

}
