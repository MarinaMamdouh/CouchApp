//
//  Date.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation

extension Date {
    
    func get(_ datePart: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
            return calendar.component(datePart, from: self)
    }
}
