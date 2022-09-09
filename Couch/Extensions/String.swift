//
//  String.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation
extension String {
    
    var toDate: Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from:self) else {return nil}
        return date
    }
    
}
