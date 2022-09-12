//
//  LocalFileManager.swift
//  Couch
//
//  Created by Marina on 08/09/2022.
//

import Foundation
import SwiftUI

// Image File Managing
class ImageFileManager: LocalFileManaging{
    private var isPngImage: Bool = true
    private let imagesFolderName: String = Constants.Files.imagesFolderName
    typealias T = UIImage
    
    // provide the ImageFileManager with our app's image type setting
    init(isPngImage: Bool){
        self.isPngImage = isPngImage
    }
    
    func save(file: UIImage, fileName: String){

        // create ImagesFolder (if not exists)
        createImagesFolder()
        
        // get image data and get Image full path
        guard let data = getData(from: file),
              let url = getImageURL(name: fileName)
        else { return }
        
        // write data to the url path
        do {
            try data.write(to: url)
        }catch let error {
            print("Error Saving Image \(fileName) in File Manager. \(error.localizedDescription)")
        }
    }
    // get image of file name if exists
    func getFile(name: String)-> UIImage?{
        guard
            let url = getImageURL(name: name),
            FileManager.default.fileExists(atPath: url.path) else{
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    // create the images folder in the cache directory if not exists yet
    private func createImagesFolder(){
        guard let url = getFolderURL() else {return}
        // check if folder is already exist
        if !FileManager.default.fileExists(atPath: url.path){
            // create the Images Folder
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            }catch {
                print("Error creating folder. Folder Name \(imagesFolderName). \(error.localizedDescription)")
            }
        }
        
    }
    
    // get the image data
    private func getData(from image: UIImage)-> Data?{
        if isPngImage{
            guard let data = image.pngData()
            else { return nil }
            
            return data
        }
        guard let data = image.jpegData(compressionQuality: 1)
        else { return nil }
        
        return data
    }
    

    // get images folder URL from inside the caches directory
    private func getFolderURL()-> URL?{
        guard let folderURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return folderURL.appendingPathComponent(imagesFolderName)
    }
    
    // get the image of name URL from inside the images folder
    private func getImageURL(name: String)-> URL?{
        guard let folderURL = getFolderURL() else { return nil }
        return folderURL.appendingPathComponent(name)
    }
}
