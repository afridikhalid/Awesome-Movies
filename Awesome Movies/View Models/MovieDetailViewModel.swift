//
//  MovieDetailViewModel.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import Foundation
import CoreData


class MovieDetailViewModel: ObservableObject {
    
    let movieId: Int
    
    @Published var title: String = ""
    @Published var year: String = ""
    @Published var runTime: String = ""
    @Published var rating: Double = 0
    @Published var ratingString: String = ""
    @Published var posterURL: URL? = nil
    @Published var overview: String = ""
    @Published var movieExists: Bool = false
    
    fileprivate var movieModel: MovieDetail?
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    
    func getMovie(with context: NSManagedObjectContext) {
        
        // if movie does exists display the saved movie
        if let movie = SavedMovie.exists(context: context, id: movieId) {
            movieExists = true
            title = movie.title ?? " - "
            posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")
            runTime = Int(movie.runtime).toHrAndMinutes.toYear
            year = movie.release_date?.toYear ?? "-"
            overview = movie.overview ?? " - "
            rating = movie.vote_average
            ratingString = String(format: "%0.1f", movie.vote_average)
            
        } else {
            Task {
                await fetchMovie(with: movieId)
            }
        }
    }
    
    // MARK: - Coredata functions
    func saveMovie(in context: NSManagedObjectContext) {
        guard let movieModel = movieModel else { return } // handle earror
        let movie = SavedMovie(context: context)
        movie.createdAt = Date()
        movie.id = Int32(movieModel.id)
        movie.title = movieModel.title
        movie.overview = movieModel.overview
        movie.poster_path = movieModel.poster_path
        movie.release_date = movieModel.release_date
        movie.runtime = Int32(movieModel.runtime)
        movie.vote_average = movieModel.vote_average
        
        do {
            try context.save()
            movieExists = true
        } catch {
            print("Error saving movie: \(error.localizedDescription)")
        }
        
    }
    
    func deleteMovie(from context: NSManagedObjectContext, completion: @escaping(Bool) -> ()) {
        guard let movie = SavedMovie.exists(context: context, id: movieId) else {
            completion(false)
            return
        }
        // delete the movie
        context.delete(movie)
        
        // save the context
        do {
            try context.save()
            movieExists = false
            completion(true)
        } catch {
            print("Error deleting movie: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    // MARK: - Api functions
    func fetchMovie(with id: Int) async {
        
        let query: [String : String] = [
            "language" : "en-US",
        ]
        
        do {
            let movieDetail: MovieDetail = try await Api.shared.execute(method: .get, path: "/movie/\(id)", query: query)
            await updateValue(for: movieDetail)
            self.movieModel = movieDetail
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
