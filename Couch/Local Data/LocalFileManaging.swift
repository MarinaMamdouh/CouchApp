//
//  LocalFileManaging.swift
//  Couch
//
//  Created by Marina on 09/09/2022.
//

import Foundation

// General File Managing for any type of file
protocol LocalFileManaging{
    associatedtype T
    func save(file:T, fileName:String)
    func getFile(name: String)-> T?
}
