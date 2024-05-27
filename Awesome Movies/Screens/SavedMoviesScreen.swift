//
//  SavedMoviesScreen.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import SwiftUI

/// this class is built without ViewModel since there's not a lot of complexity of data
struct SavedMoviesScreen: View {
    
    @Environment(\.managedObjectContext) private var context
    
    // fetched all saved movies, now we sort it by created/saved at date so
    // last saved movies be at the top of the list or bottom based on order
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \SavedMovie.createdAt, ascending: false)], animation: .default)
    private var movies: FetchedResults<SavedMovie>
    
    
    // MARK: - functions
    private func deleteMovies(at offsets: IndexSet) {
        withAnimation {
            offsets.map { movies[$0] }.forEach(context.delete)
            
            do {
                try context.save()
            } catch {
                // we can convert the error to NSError as well to get userInfo
                // for more information
                fatalError("Unresolved error: \(error.localizedDescription)")
            }
        }
    }
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Group {
                // In case user has not saved any movie yet
                if movies.isEmpty {
                    ContentUnavailableView("Empty",
                                           systemImage: "folder",
                                           description: Text("Save any movie from movies list then it will be available in your downloads"))
                    
                } else {
                    List {
                        // To be able to implmeent .onDelete instead of iterating in ListView movied and added a ForEach so we can attach the .onDelete
                        ForEach(movies) { movie in
                            ZStack {
                                
                                SavedMovieCell(movie: movie)
                                    .backgroundStyle(.clear)
                                NavigationLink {
                                    MovieDetailScreen(movieId: Int(movie.id))
                                    
                                } label: { Text(" ")}
                                
                                    .opacity(0)
                            }
                        }
                        .onDelete(perform: deleteMovies)
                        
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
