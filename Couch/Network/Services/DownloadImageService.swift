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
    private let imageFileManager = ImageFileManager(isPngImage: Constants.Files.isImageTypePNG)
    private var imageSubscription: AnyCancellable?
    
    init(imagePath: String, imageSize: String){
        self.imagePath = imagePath
        self.imageSize = imageSize
        getImage()
    }
    
    init(imageSize:String){
        self.imageSize  = imageSize
        self.imagePath = ""
    }
    
    func getImage(path: String){
        self.imagePath = path
        getImage()
    }
    
    private func getImage(){
        if !checkIfImageExists(){
            downloadImage()
        }
    }
    
    private func checkIfImageExists()-> Bool{
        if let savedImage =  imageFileManager.getFile(name: imagePath) {
            self.image = savedImage
            print("Recieved Image from File Manager.")
            return true
        }
        return false
    }
    
    private func downloadImage(){
        
        let api = APIRequest.getImage(imagePath, imageSize)
        let request = api.asRequest()
        self.imageSubscription = NetworkManager.performRequest(request)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] recievedImage in
                guard let self = self,
                      let recievedImage = recievedImage else {return}
                print("Image downloaded \(self.imagePath)")
                self.image = recievedImage
                self.imageFileManager.save(file: recievedImage, fileName: self.imagePath)
                self.imageSubscription?.cancel()
            })
        
    }
    
}
