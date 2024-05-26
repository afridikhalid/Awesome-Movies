//
//  MovieDetailViewModel.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    let movieId: Int
    @Published var title: String = ""
    @Published var year: String = ""
    @Published var runTime: String = ""
    @Published var rating: Double = 0
    @Published var ratingString: String = ""
    @Published var posterURL: URL? = nil
    @Published var overview: String = ""
    
    
    
    init(movieId: Int) {
        self.movieId = movieId
        
        Task {
            await fetchMovie(with: movieId)
        }
        
    }
    
    func fetchMovie(with id: Int) async {
        
        let query: [String : String] = [
            "language" : "en-US",
        ]
        
        do {
            let movieDetail: MovieDetail = try await Api.shared.execute(method: .get, path: "/movie/\(id)", query: query)
            await updateValue(for: movieDetail)
            
        } catch {
            print("Error fetching movie detail: \(error.localizedDescription)")
        }
        
    }
    
    
    
    @MainActor
    private func updateValue(for movie: MovieDetail) {
        
        title = movie.title
        posterURL = movie.posterImageURL
        rating = movie.vote_average
        runTime = movie.runtime.toHrAndMinutes
        year = movie.release_date.toYear
        overview = movie.overview
        ratingString = String(format: "%0.1f", movie.vote_average)
        
    }
    
    
}
