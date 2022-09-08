//
//  DownloadImageService.swift
//  Couch
//
//  Created by Marina on 08/09/2022.
//

import Foundation
import SwiftUI
import Combine

class DownloadImageService{
    @Published var image: UIImage?
    private var imagePath: String
    private var imageSize: String
    private var imageSubscription: AnyCancellable?
    
    init(imagePath: String, imageSize: String){
        self.imagePath = imagePath
        self.imageSize = imageSize
        downloadImage()
    }
    
    private func downloadImage(){
        let api = APIRequest.getImage(imagePath, imageSize)
        let request = api.asRequest()
        
        self.imageSubscription = NetworkManager.performRequest(request)
        .tryMap({ (data) -> UIImage? in
            return UIImage(data: data)
        })
        .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] recievedImage in
            self?.image = recievedImage
            self?.imageSubscription?.cancel()
        })
        
    }
}
