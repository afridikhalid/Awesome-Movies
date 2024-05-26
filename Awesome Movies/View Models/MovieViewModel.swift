//
//  MovieViewModel.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-19.
//

import Foundation

class MovieViewModel: ObservableObject {
    
    @Published var topRatedMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    
    
    /// This Function uses multiple concurrent task
    ///
    ///   - Note
    ///      Asynchronus tasks are useful when we want to free resources for the system to perform other tasks, like updating the interface, but when we want to run two tasks simultaneously, we need concurrency.
    ///      For this purpose , the Swift Standard Library defines the `async let` statement.
    ///      To turn an asynchronous task into multiple concurrent tasks, all we need to do is to declare the processes
    ///      with the `async let` statement.
    @MainActor
    func fetchMovies() async {
        
        // we generate the query keys and values here so in case we want to change sort by with different queries
        /*
        let query: [String : String] = [
            QueryItemKey.include_adult.rawValue : "false",
            QueryItemKey.include_video.rawValue : "false",
            QueryItemKey.page.rawValue : "1",
            QueryItemKey.sort_by.rawValue : SortByQueryItemValue.popularity.value
        ]
        */
        
        let query: [String : String] = [
            "language" : "en-US",
            "page" : "1"
        ]
        
        
        
        
        do {
            
            // Top Rated Movies
            async let topRatedMoviesResult: MovieResultModel = try await Api.shared.execute(method: .get, path: "/movie/top_rated", query: query)
            topRatedMovies = try await topRatedMoviesResult.results
            
            // Now Playing Movies
            async let nowPlayingMoviesResult: MovieResultModel = try await Api.shared.execute(method: .get, path: "/movie/now_playing", query: query)
            nowPlayingMovies = try await nowPlayingMoviesResult.results
            
            // Popular Movies
            async let popularMoviesResult: MovieResultModel = try await Api.shared.execute(method: .get, path: "/movie/popular", query: query)
            popularMovies = try await popularMoviesResult.results
            
            // Upcoming Movies
            async let upcomingMoviesResult: MovieResultModel = try await Api.shared.execute(method: .get, path: "/movie/upcoming", query: query)
            upcomingMovies = try await upcomingMoviesResult.results
            
        } catch {
            print("Error fetching movies: \(error.localizedDescription)")
        }
        
    }
    
    
}
