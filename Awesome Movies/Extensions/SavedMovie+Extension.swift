//
//  SavedMovie+Extension.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import Foundation
import CoreData

extension SavedMovie {
    
    /// We add the discardable result in case we don't want to use the result so this function
    /// will be used like a simple bool check if == nil or we can use it like
    /// `let movie = exists` returns a movie as well
    @discardableResult
    static func exists(context: NSManagedObjectContext, id: Int) -> SavedMovie? {
        let request = SavedMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %i", id)
        request.fetchLimit = 1
        
        // if we get any movie with same id then we know it already exists else it's missing
        // we can wrape this in a do catch as well for simplicity i did do optional try
        return try? context.fetch(request).first
        
    }
    
    
    static func dummeSavedMovie(for context: NSManagedObjectContext) -> SavedMovie {
        
        let kingdomOfPlanetMovie = SavedMovie(context: context)
        kingdomOfPlanetMovie.id = 653346
        kingdomOfPlanetMovie.title = "Kingdom of the Planet of the Apes"
        kingdomOfPlanetMovie.overview = "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike."
        kingdomOfPlanetMovie.runtime = 145
        kingdomOfPlanetMovie.vote_average = 7.159
        kingdomOfPlanetMovie.release_date = "2024-05-08"
        kingdomOfPlanetMovie.poster_path = "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg"
        
        do {
            try context.save()
        } catch {
            print("==> Error saving to movie model: \(error.localizedDescription)")
        }
        
        return kingdomOfPlanetMovie
    }
    
}
