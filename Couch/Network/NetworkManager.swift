//
//  NetworkManager.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import Foundation
import Combine

class NetworkManager{
    
    // perform a given request by Creating a publisher that publishes a retrieved data when task is completed
    // return that created publisher
    static func performRequest(_ request:URLRequest) -> AnyPublisher<Data, Error>{
         return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleResponse(from: request, output: $0) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // handle the response output from a given request
    // checks if response is successful or not
    // return the output data
    private static func handleResponse(from request: URLRequest ,output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw AppErrors.networkError(request.url?.absoluteString ?? "")
        }
        return output.data
    }
    
    // handle the completion of the task
    // check if it is successfully finished or has failed
    static func handleCompletion(_ completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
