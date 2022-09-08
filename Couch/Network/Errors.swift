//
//  Errors.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import Foundation

enum AppErrors: LocalizedError{
    case networkError(_ url: String)
    case unknownError
    
    var errorDescription: String?{
        switch self {
        case .networkError(let url):
            return "[⚠️] Bad response from the API URL: \(url)"
        case .unknownError:
            return "[⚠️] unknow error occurred"
        }
    }
}
