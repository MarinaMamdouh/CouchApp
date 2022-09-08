//
//  NetworkManager.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import Foundation
import Combine

class NetworkManager{
    static func performRequest(_ request:URLRequest) -> AnyPublisher<Data, Error>{
         return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleResponse(from: request, output: $0) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private static func handleResponse(from request: URLRequest ,output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw AppErrors.networkError(request.url?.absoluteString ?? "")
        }
        return output.data
    }
    
    static func handleCompletion(_ completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
