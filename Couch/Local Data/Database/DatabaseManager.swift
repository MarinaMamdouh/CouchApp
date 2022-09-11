//
//  DatabaseManager.swift
//  Couch
//
//  Created by Marina on 10/09/2022.
//

import Foundation
import CoreData

// protocol for Entities database handling
protocol DatabaseHandling{
    associatedtype T
    var entityName: String {get}
    static var container: NSPersistentContainer {get}
    func save(_ items:[T])
    func save(_ item:T)
    func delete(_ item:T)
    func fetchData()->[T]
}

class DatabaseManager{
    
    
    static func getPresistanceContainer(container: String) -> NSPersistentContainer{
        let container = NSPersistentContainer(name: container)
            container.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Unable to load persistent stores: \(error)")
                }
            }
            return container
    }

}
