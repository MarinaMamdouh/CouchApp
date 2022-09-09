//
//  LocalFileManager.swift
//  Couch
//
//  Created by Marina on 08/09/2022.
//

import Foundation
import SwiftUI

class ImageFileManager: LocalFileManaging{
    private var isPngImage: Bool = true
    private let imagesFolderName: String = Constants.Files.imagesFolderName
    typealias T = UIImage
    
    init(isPngImage: Bool){
        self.isPngImage = isPngImage
    }
    
    func save(file: UIImage, fileName: String){

        // create ImagesFolder (if not exists)
        createImagesFolder()
        
        // get image data
        // get Image full path
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
    
    func getFile(name: String)-> UIImage?{
        guard
            let url = getImageURL(name: name),
            FileManager.default.fileExists(atPath: url.path) else{
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
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
    

    
    private func getFolderURL()-> URL?{
        guard let folderURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return folderURL.appendingPathComponent(imagesFolderName)
    }
    
    private func getImageURL(name: String)-> URL?{
        guard let folderURL = getFolderURL() else { return nil }
        return folderURL.appendingPathComponent(name)
    }
}
