//
//  MainScreen.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import SwiftUI

/// Main Screen is used as a TabView
struct MainScreen: View {
    
    var body: some View {
        
        TabView {
            
            MoviesScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
            
            SavedMoviesScreen()
                .tabItem {
                    Image(systemName: "square.and.arrow.down.fill")
                    Text("Downloads")
                }
            SettingsScreen()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
        } //: End of TAB
        
    }
}

#Preview {
    MainScreen()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
