//
//  DateService.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 13.03.22.
//

import Foundation

final class DateService {
    
    func getWeekday(fromDate: Int) -> String {
        
        let dateformater = DateFormatter()
        dateformater.dateFormat = "E"
        
        let incomeTimeinterval = TimeInterval(fromDate)
        let date = Date(timeIntervalSince1970: incomeTimeinterval)
        
        let incomeWeakDayStr =  dateformater.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        let currentWeakDay = dateformater.weekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1]
        
        return incomeWeakDayStr == currentWeakDay ? "Today" : dateformater.string(from: date)
    }
    
    func getHour(fromDate: Int) -> String {
        
        let incomeTimeinterval = TimeInterval(fromDate)
        let date = Date(timeIntervalSince1970: incomeTimeinterval)
        
        let hour = Calendar.current.component(.hour, from: date)
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        return hour == currentHour ? "Now" : String(hour)
    }
    
    
}
