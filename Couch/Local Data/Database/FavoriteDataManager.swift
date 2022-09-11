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
    
    typealias T = FavoriteMovieEntity
    
    private var managedContext: NSManagedObjectContext?
    
    @Published var favoriteMovies: [FavoriteMovieEntity] = []
    @Published var requestedFavoriteMovie: FavoriteMovieEntity?
    
    var entityName: String = Constants.Database.favoriteMovieEntity
    
    static private(set) var container = DatabaseManager.getPresistanceContainer(container: Constants.Database.moviesContainer)
    
    func save(_ items: [FavoriteMovieEntity]) {
        for item in items {
            save(item)
        }
    }
    
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
            // reload favmovies publisher
            _ = self.fetchData()
        } catch let error as NSError {
            print("Could not save. \(error.localizedDescription)")
        }
    }
    
    func delete(_ item: FavoriteMovieEntity) {
        // get presistentContainer's context of core data
        let managedContext =
        FavoriteDataManager.container.viewContext
        // get entity
        let fetchRequest = NSFetchRequest<FavoriteMovieEntity>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "\(Constants.Database.FavoriteMovieKeys.id) == %@", NSNumber(integerLiteral: Int(item.id)))
        do{
            let entities = try FavoriteDataManager.container.viewContext.fetch(fetchRequest)
            for entity in entities {
                managedContext.delete(entity)
            }
            try managedContext.save()
            _ = fetchData()
            
        }catch{
            print("could not fetch. \(error.localizedDescription)")
            self.requestedFavoriteMovie = nil
        }
        
    }
    
    
    func fetchData() -> [FavoriteMovieEntity] {
        let fetchRequest = NSFetchRequest<FavoriteMovieEntity>(entityName: entityName)
        
        do{
            let entities = try FavoriteDataManager.container.viewContext.fetch(fetchRequest)
            self.favoriteMovies = entities
            return entities
        }catch{
            print("could not fetch. \(error.localizedDescription)")
            self.favoriteMovies = []
            return []
        }
        
    }
    
    
    func getFavoriteMovie(of id:Int){
        let fetchRequest = NSFetchRequest<FavoriteMovieEntity>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "\(Constants.Database.FavoriteMovieKeys.id) == %@", NSNumber(integerLiteral: id))
        do{
            let entity = try FavoriteDataManager.container.viewContext.fetch(fetchRequest)
            self.requestedFavoriteMovie = entity.first ?? nil
        }catch{
            print("could not fetch. \(error.localizedDescription)")
            self.requestedFavoriteMovie = nil
        }
    }
    
}
