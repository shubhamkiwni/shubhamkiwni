//
//  DateFormatter.swift
//  Kiwni
//
//  Created by Admin on 31/01/22.
//

import Foundation
extension DateFormatter {
    /**
     Returns formatter with 'dd/MM/yyyy' format
     */
    static let ddMMyyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'MMM yyyy' format
     */
    static let MMM_yyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'dd-MMM-yyyy' format
     */
    static let ddMMMyyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'dd-MMM-yyyy HH:mm' format
     */
    static let ddMMMyyyy_HHmm: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'hh:mm a' format
     */
    static let hhmm_a: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'yyyy-MM-dd'T'HH:mm:ss' format
     */
    static let yyyyMMdd_T_HHmmss: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'yyyy-MM-dd'T'HH:mm:ssZ' format
     */
    static let yyyyMMdd_T_HHmmssZ: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'yyyy-MM-dd'T'HH:mm:ss.SSS' format
     */
    static let yyyyMMdd_T_HHmmss_SSS: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter
    }()

    /**
     Returns formatter with 'yyyy-MM-dd'T'HH:mm:ss.SSSZ' format
     */
    static let yyyyMMdd_T_HHmmss_SSSZ: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'MMM dd, yyyy' format
     */
    static let MMM_dd_yyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'MMM d, yyyy' format
     */
    static let MMM_d_yyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'EEEE, MMM d, yyyy' format
     */
    static let EEEE_MMM_d_yyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter
    }()
    
    /**
     Returns formatter with 'yyyy/MM/dd' format
     */
    static let yyyyMMdd: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
}
