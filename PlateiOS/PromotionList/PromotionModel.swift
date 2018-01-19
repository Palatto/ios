//
//  CardModel.swift
//  PlateiOS
//
//  Created by Nick Machado on 11/11/17.
//  Copyright © 2017 Renner Leite Lucena. All rights reserved.
//

import Foundation

// Our promotionModel, one for each event/promotion.
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
    
    // The inits can be in the declaration of the class (not necesssary to have extension for this)
    init(promotion_id: String, title: String, start_time: String, end_time: String, location: String) {        
        self.promotion_id = promotion_id
        self.title = title
        self.start_time = formatTime(time: start_time)
        self.end_time = formatTime(time: end_time)
        self.location = location
    }
}

// Extension for organization
extension PromotionModel {
    
    fileprivate func formatTime(time: String) -> String {
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let time_output: Date? = dateFormatterOutput.date(from: time)
        if time_output != nil {
            return time
        }
        
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let time_input: Date? = dateFormatterInput.date(from: start_time)
        
        if let time_input = time_input {
            return dateFormatterOutput.string(from: time_input)
        }
        
        return time
    }
    
    public func getParsedDateTime() -> String {
        let dateString = getDate(time: start_time)
        let startTimeString = getTime(time: start_time)
        let endTimeString = getTime(time: end_time)
        return (dateString + " from " + startTimeString + " to " + endTimeString)
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
        let timeSubstring = time[range]  // play
        
        return String(timeSubstring)
    }
}

