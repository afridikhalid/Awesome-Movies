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
                    // an example of how we can prefill in the string catalogs comments
                    Text("Home", comment: "Tab bar name for the home tab")
                }
                
            
            SavedMoviesScreen()
                .tabItem {
                    Image(systemName: "square.and.arrow.down.fill")
                    Text("Downloads", comment: "Tab bar name for the downloads tab where user can view their saved movies")
                }
            SettingsScreen()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings", comment: "Tab bar name for the settings tab view / screen")
                }
            
        } //: End of TAB
        
    }
}

#Preview {
    MainScreen()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}

// MARK: - Swedish Preview
#Preview {
    MainScreen()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
        .environment(\.locale, Locale(identifier: "sv"))
}
