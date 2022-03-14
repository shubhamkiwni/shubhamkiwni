
import  Foundation

extension Date {
    var minute: Int { return Calendar.current.component(.minute, from: self) }
    
    var nextHalfHour: Date {
        return Calendar.current.nextDate(after: self, matching: DateComponents(minute: minute >= 30 ? 0 : 30), matchingPolicy: .strict)!
    }
    var nextQuarterHour: Date {
        return Calendar.current.nextDate(after: self, matching: DateComponents(minute: minute >= 15 ? minute >= 30 ? minute >= 45 ? 0 : 45 : 30 : 15), matchingPolicy: .strict)!
    }
    
    
    
}

enum interval: Int {
  case minutes15 = 15
  case minutes30 = 30
  case minutes45 = 45
  case minutes60 = 60
}
