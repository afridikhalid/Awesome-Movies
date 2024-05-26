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
        
        return String(format: "%dh %02d min", hr, min)
        
    }
    
}
