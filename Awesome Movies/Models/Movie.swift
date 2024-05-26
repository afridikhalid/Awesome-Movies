//
//  Movie.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-19.
//

import Foundation


/// Movie Result Model a codable struct since discover/movies does not send directly an array of the movies but it has some extra information
/// We could create a separate file for this but since it has only number of pages, results and returns current page which later one we can use
/// it for pagination in case we implement pagination
struct MovieResultModel: Codable {
    
    let page: Int
    let total_pages: Int
    let total_results: Int
    let results: [Movie]
    
}


// there are some more parameters that we can parse if needed
struct Movie: Codable, Identifiable {
    
    let id: Int
    let title: String
    let original_title: String
    let overview: String
    let genre_ids: [Int]
    let backdrop_path: String?
    let poster_path: String?
    let popularity: Double
    let vote_average: Double
    let release_date: String
    
    
    
    var posterImageURL: URL? {
        guard let posterPath = poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        
    }
    
}


extension Movie {
    /// creates a single demo movie so we can use it in previews
    static let dummeMovie = Movie(id: 823464,
                          title: "Godzilla x Kong: The New Empire",
                          original_title: "Godzilla x Kong: The New Empire",
                          overview: "Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.",
                          genre_ids: [878, 28, 12],
                          backdrop_path: "/j3Z3XktmWB1VhsS8iXNcrR86PXi.jpg",
                          poster_path: "/tMefBSflR6PGQLv7WvFPpKLZkyk.jpg",
                          popularity: 9778.73,
                          vote_average: 7.179,
                          release_date: "2024-03-27")
}
