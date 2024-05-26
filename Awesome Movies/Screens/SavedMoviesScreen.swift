//
//  SavedMoviesScreen.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import SwiftUI

/// this class is built without ViewModel since there's not a lot of complexity of data
struct SavedMoviesScreen: View {
    
    // fetched all saved movies, we can add sort through sort discriptors
    // for future updates
    @FetchRequest(sortDescriptors: [], animation: .default) private var movies: FetchedResults<SavedMovie>
    
    
    
    var body: some View {
        NavigationStack {
            Group {
                // In case user has not saved any movie yet
                if movies.isEmpty {
                    ContentUnavailableView("Empty",
                                           systemImage: "folder",
                                           description: Text("Save any movie from movies list then it will be available in your downloads"))
                    
                } else {
                    List(movies) { movie in
                        
                        ZStack {
                            
                            SavedMovieCell(movie: movie)
                                .backgroundStyle(.clear)
                            NavigationLink {
                                MovieDetailScreen(movieId: Int(movie.id))
                                    
                            } label: { Text(" ")}
                                
                            .opacity(0)
                            
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)

                    }
                    .listStyle(.plain)
                    
                    
                }
            }
            
            .navigationTitle("Saved Movies")
        }
        
    }
    
}


#Preview {
    SavedMoviesScreen()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
