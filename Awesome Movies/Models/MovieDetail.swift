//
//  MovieDetail.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import Foundation

struct MovieDetail: Codable {
    
    let id: Int
    let title: String
    let overview: String
    let vote_average: Double
    let poster_path: String?
    let release_date: String
    let runtime: Int
    
    
    var posterImageURL: URL? {
        guard let posterPath = poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        
    }
    
}


extension MovieDetail {
    static let dummeMovieDetail = MovieDetail(id: 823464, title: "Godzilla x Kong: The New Empire", overview: "Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.", vote_average: 7.179, poster_path: "/tMefBSflR6PGQLv7WvFPpKLZkyk.jpg", release_date: "2024-03-27", runtime: 115)
}
