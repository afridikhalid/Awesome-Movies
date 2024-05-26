//
//  CoreDataProvider.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import Foundation
import CoreData


/// Core data provider class is responsible to make sure the coredata stack is setup properly and is available.
/// We code name as `CoreDataStack` as well
/// We can create a singleton of this class similar to the Api() to access it using .shared property but i just wanted to show
/// how can we pass the context using environement
class CoreDataProvider {
    
    let persistentContainer: NSPersistentContainer
    
    
    /// it simply returns the Persistent Containers View Context so we don't call peristentContainer.viewContext
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    
    /// this property is only for previews and not production / release
    static var preview: CoreDataProvider = {
        
        let provider = CoreDataProvider(inMemory: true)
        let context = provider.context
        
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
        
        return provider
    }()
    
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "AwesomeMovieAppModel")
        
        // if in Memory is true then we are not writing data to the model
        // used for #previous
        if inMemory {
            // This code is from apple doc. so i just passed is as it is
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                // if it fails then we can not do much in this state we can send the fatal message for debuging
                fatalError("Failed to initialize coredata store: \(error)")
            }
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
}
