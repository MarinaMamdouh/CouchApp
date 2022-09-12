//
//  FavoriteDataManager.swift
//  Couch
//
//  Created by Marina on 10/09/2022.
//

import Foundation
import CoreData
import Combine

class FavoriteDataManager: ObservableObject, DatabaseHandling{
    
    @Published var favoriteMovies: [FavoriteMovieEntity] = []
    @Published var requestedFavoriteMovie: FavoriteMovieEntity?
    
    typealias T = FavoriteMovieEntity
    var entityName: String = Constants.Database.favoriteMovieEntity
    
    private var managedContext: NSManagedObjectContext?
    static private(set) var container = DatabaseManager.getPresistanceContainer(container: Constants.Database.moviesContainer)
    
    // save patch of items in core data
    func save(_ items: [FavoriteMovieEntity]) {
        for item in items {
            save(item)
        }
    }
    
    // save item in core data
    func save(_ item: FavoriteMovieEntity) {
        // get presistentContainer's context of core data
        let managedContext =
        FavoriteDataManager.container.viewContext
        
        // avoid duplicate entry by merging depending on the primary key "id"
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        // save object to database
        do {
            try managedContext.save()
            print("Saved in Database")
            // reload favorite movies publisher
            self.fetchData()
        } catch let error as NSError {
            print("Could not save. \(error.localizedDescription)")
        }
    }
    
    
    func delete(_ item: FavoriteMovieEntity) {
        // get presistentContainer's context of core data
        let managedContext =
        FavoriteDataManager.container.viewContext
        // create the request of fetching FavoriteMovieEntities
        let fetchRequest = NSFetchRequest<FavoriteMovieEntity>(entityName: entityName)
        // get entity of id == item.id
        fetchRequest.predicate = NSPredicate(format: "\(Constants.Database.FavoriteMovieKeys.id) == %@", NSNumber(integerLiteral: Int(item.id)))
        do{
            let entities = try FavoriteDataManager.container.viewContext.fetch(fetchRequest)
            // delete retrieved entities
            for entity in entities {
                managedContext.delete(entity)
            }
            // save the context
            try managedContext.save()
            // reload the data
            fetchData()
            
        }catch{
            print("could not fetch. \(error.localizedDescription)")
            self.requestedFavoriteMovie = nil
        }
        
    }
    
    // get all data in the container of type FavoriteMovieEntity
    func fetchData(){
        // create the request of fetching FavoriteMovieEntities
        let fetchRequest = NSFetchRequest<FavoriteMovieEntity>(entityName: entityName)
        
        do{
            // get the entities
            let entities = try FavoriteDataManager.container.viewContext.fetch(fetchRequest)
            self.favoriteMovies = entities
        }catch{
            print("could not fetch. \(error.localizedDescription)")
            self.favoriteMovies = []
        }
        
    }
    
    
    func getFavoriteMovie(of id:Int){
        // create the request of fetching FavoriteMovieEntities
        let fetchRequest = NSFetchRequest<FavoriteMovieEntity>(entityName: entityName)
        // get entity of id == item.id
        fetchRequest.predicate = NSPredicate(format: "\(Constants.Database.FavoriteMovieKeys.id) == %@", NSNumber(integerLiteral: id))
        do{
            let entity = try FavoriteDataManager.container.viewContext.fetch(fetchRequest)
            // update the requested Favorite Movie of the given id if exists in the favorites
            self.requestedFavoriteMovie = entity.first ?? nil
        }catch{
            print("could not fetch. \(error.localizedDescription)")
            self.requestedFavoriteMovie = nil
        }
    }
    
}
