//
//  Awesome_MoviesApp.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-19.
//

import SwiftUI

@main
struct Awesome_MoviesApp: App {
    
    let provider: CoreDataProvider
    
    init() {
        provider = CoreDataProvider()
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(\.managedObjectContext, provider.context)
        }
    }
}
