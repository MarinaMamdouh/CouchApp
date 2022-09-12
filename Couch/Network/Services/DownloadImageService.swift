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
    // provide the imageFileManager with our app's image type setting
    private let imageFileManager = ImageFileManager(isPngImage: Constants.Files.isImageTypePNG)
    private var imageSubscription: AnyCancellable?
    
    // initialize with the image path and image size
    // imageSize: w185, "w92", "w154", "w185",... etc
    // you can get imageSize app compatiable values from Constants.APIs
    init(imagePath: String, imageSize: String){
        self.imagePath = imagePath
        self.imageSize = imageSize
        getImage()
    }
    
    private func getImage(){
        if !checkIfImageExists(){
            downloadImage()
        }
    }
    // check if image exists in file manager (cached folder)
    private func checkIfImageExists()-> Bool{
        if let savedImage =  imageFileManager.getFile(name: imagePath) {
            self.image = savedImage
            return true
        }
        return false
    }
    
    private func downloadImage(){
        // get api request with image path and image Size
        let api = APIRequest.getImage(imagePath, imageSize)
        let request = api.asRequest()
        // listen to the request's response
        self.imageSubscription = NetworkManager.performRequest(request)
            .tryMap({ (data) -> UIImage? in
                // map the response data to UIImage
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] recievedImage in
                guard let self = self,
                      let recievedImage = recievedImage else {return}
                // update the image
                self.image = recievedImage
                // save the downloaded image to file manager
                self.imageFileManager.save(file: recievedImage, fileName: self.imagePath)
                // cancel subscription to be released on dinitialization
                self.imageSubscription?.cancel()
            })
        
    }
    
}
