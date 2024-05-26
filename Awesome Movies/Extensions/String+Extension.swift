//
//  String+Extension.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import Foundation


extension String {
    
    
    /// Date format which is sent from backend is `2024-03-27`
    var toYear: String {
        // Create a new date from received string
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = .current
        
        // in case it fails to get the have to implement a fall back
        guard let date = formatter.date(from: self) else { return "No Date" }
        
        formatter.dateFormat = "YYYY"
        return formatter.string(from: date)
    }
    
    
    
}
