//
//  MovieGridCellViewModel.swift
//  Couch
//
//  Created by Marina on 08/09/2022.
//

import Foundation
import SwiftUI
import Combine

class MovieGridCellViewModel: ObservableObject{
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = true
    
    let movie: MovieModel
    private let downloadImageService: DownloadImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(movieModel: MovieModel){
        self.movie = movieModel
        self.downloadImageService = DownloadImageService(imagePath: movie.posterPath, imageSize: Constants.APIs.posterImageSize)
        addSubscribers()
        
    }
    
    private func addSubscribers(){
        downloadImageService.$image
            .sink { [weak self] recievedImage in
                print("Image downloaded")
                self?.image = recievedImage

            }
            .store(in: &cancellables)
        
        $image
            .sink { [weak self] currentImage in
                if currentImage != nil {
                    self?.isLoading = false
                }
            }
            .store(in: &cancellables)

    }
}
