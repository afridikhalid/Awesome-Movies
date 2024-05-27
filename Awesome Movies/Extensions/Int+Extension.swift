//
//  Int+Extension.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import Foundation


extension Int {
    
    /// This will format the runtime / duration of the movie to hour and minutes with some formatted string
    var toHrAndMinutes: String {
        
        let hr = self / 60
        let min = self % 60
        
        return String(format: String(localized: "%dh %02d min", comment: "Runtime or duration of a movie where h is hour and min is minutes and %d and %02d are place holders for the calculate duration"), hr, min)
        
    }
    
}
