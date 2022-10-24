//
//  String+Extension.swift
//  Gist
//
//  Created by gabriel hideki on 23/10/22.
//

import Foundation

extension String {
    func timeSince(withFormat: String) -> DateComponents? {
        var calendar = NSCalendar.autoupdatingCurrent
        calendar.timeZone = NSTimeZone.system
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = calendar.timeZone
        dateFormatter.dateFormat = withFormat
        
        if let startDate = dateFormatter.date(from: self) {
            return calendar.dateComponents([ .month, .day, .hour, .minute, .second], from:startDate , to:Date())
        } else {
            return nil
        }
    }
}
