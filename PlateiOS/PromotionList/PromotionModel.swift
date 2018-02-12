//
//  CardModel.swift
//  PlateiOS
//
//  Created by Nick Machado on 11/11/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import Foundation

class PromotionModel: Decodable, Hashable {
    
    var hashValue: Int {
        return promotion_id.hashValue
    }
    
    static func == (lhs: PromotionModel, rhs: PromotionModel) -> Bool {
        return lhs.promotion_id == rhs.promotion_id
    }
    
    var promotion_id: String = ""
    var title: String = ""
    var start_time: String = ""
    var end_time: String = ""
    var location: String = ""
    
    init(promotion_id: String, title: String, start_time: String, end_time: String, location: String) {        
        self.promotion_id = promotion_id
        self.title = title
        self.start_time = formatTime(time: start_time)
        self.end_time = formatTime(time: end_time)
        self.location = location
    }
}

extension PromotionModel {
    
    fileprivate func formatTime(time: String) -> String {
        // Check if it is already on the right format
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let time_output: Date? = dateFormatterOutput.date(from: time)
        if time_output != nil {
            return time
        }
        
        // If not, creates input formatter that finally outputs what we want.
        let dateFormatterInput = DateFormatter()
        // Change how database store, and this function later to avoid this check.
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let time_input: Date? = dateFormatterInput.date(from: time)
        
        if let time_input = time_input {
            // Output returned
            return dateFormatterOutput.string(from: time_input)
        }
        
        // If did not returned so far, return time - error probably happened.
        return time
    }
    
    public func getParsedDateTime() -> String {
        // The input will always be "yyyy-MM-dd HH:mm:ss". Our desired output is
        // "EEEE, MMMM-dd h:mm a".
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        var startDateObject = dateFormatterInput.date(from: start_time)
        var endDateObject = dateFormatterInput.date(from: end_time)
        
        // Change this later - add 8 hours to solve timezone problem
        if(startDateObject == nil || endDateObject == nil) {
            dateFormatterInput.dateFormat = "yyyy-MM-dd HH:mm:ss"
            startDateObject = dateFormatterInput.date(from: start_time)
            endDateObject = dateFormatterInput.date(from: end_time)
        }else {
            let calendar = Calendar.current
            startDateObject = calendar.date(byAdding: .hour, value: +8, to: startDateObject!)
            endDateObject = calendar.date(byAdding: .hour, value: +8, to: endDateObject!)
        }
        
        if let startDateObject = startDateObject, let endDateObject = endDateObject {
            // Change format to desired output
            let dateFormatterOutput = DateFormatter()
            
            // Output month weekday and day first. Check if we are in the same week to do this.
            var dateString = ""
            
            let calendar = Calendar.current
            let startDay = calendar.ordinality(of: .day, in: .month, for: Date())!
            let endDay = calendar.ordinality(of: .day, in: .month, for: startDateObject)!
            let daysDifference = endDay - startDay
            
            // Checks and setup of dateString
            if(daysDifference < 7) {
                if(daysDifference == 0) {
                    dateString = "Today"
                }else if(daysDifference == 1) {
                    dateString = "Tomorrow"
                }else {
                    dateFormatterOutput.dateFormat = "EEEE"
                    dateString = dateFormatterOutput.string(from: startDateObject)
                }
            }else {
                dateFormatterOutput.dateFormat = "MMMM dd"
                dateString = dateFormatterOutput.string(from: startDateObject)
            }
            
            // Output symbol either AM or PM
            dateFormatterOutput.dateFormat = "a"
            dateFormatterOutput.amSymbol = "AM"
            dateFormatterOutput.pmSymbol = "PM"
            
            // Output hours with
            dateFormatterOutput.dateFormat = "h:mm a"
            let startTimeString = dateFormatterOutput.string(from: startDateObject)
            let endTimeString = dateFormatterOutput.string(from: endDateObject)
            
            // Complete string returned
            return (dateString + " from " + startTimeString + " to " + endTimeString)
        }else {
            // Error in parsing
            return "Monday from 0:00 to 0:00 AM"
        }
    }

    fileprivate func getDate(time: String) -> String {
        let start = time.startIndex
        let end = time.index(time.startIndex, offsetBy: 10)
        let range = start..<end
        let dateSubstring = time[range]

        return String(dateSubstring)
    }

    fileprivate func getTime(time: String) -> String {
        let start = time.index(time.startIndex, offsetBy: 11)
        let end = (time.count != 19) ? time.index(time.endIndex, offsetBy: -8) : time.index(time.endIndex, offsetBy: -3)
        let range = start..<end
        let timeSubstring = time[range]

        return String(timeSubstring)
    }
}

