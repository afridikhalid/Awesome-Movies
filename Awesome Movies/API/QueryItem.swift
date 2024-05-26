//
//  QueryItem.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-20.
//

import Foundation


/// We use `QueryItem` Enum for later on in case we implmenent any kind of request where user can chose based on different query params
/// for reference of param types visit `https://developer.themoviedb.org/reference/discover-movie`
enum QueryItemKey: String {
    case include_adult
    case include_video
    case language
    case page
    case sort_by
}

/// we can add more too the sort values in case we want to sort / get by different values
///   - NOTE:
///    all values sorted by .desc but they have `asc` as well which we can add them. but some of the values does not working and `https://developer.themoviedb.org/reference/discover-movie` returns no data
enum SortByQueryItemValue: String {
    /// returns all sort types/values that we support
    static let all: [SortByQueryItemValue] = [.popularity, .vote_count,]
    /// default sorts based on `Popularity` in case users don't select any other sort value
    static let `default` = popularity.rawValue
    
    case popularity = "Popularity"
    case vote_count = "Vote Count"
    
    var value: String {
        switch self {
        case .popularity:
            return "popularity.desc"
        case .vote_count:
            return "vote_count.desc"
        }
    }
    
}
