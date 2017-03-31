//
//  ImageStore.swift
//  Homepwner3
//
//  Created by LARRY COMBS on 3/2/17.
//  Copyright © 2017 LARRY COMBS. All rights reserved.
//

import UIKit

class ImageStore {

    let cache = NSCache<NSString,UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        //create full url tor image 
        let url = imageURL(forKey: key)
        
        //turn image into JPEG data
        if let data = UIImageJPEGRepresentation(image, 0.5){
            //Write it to full URL 
            let _ = try? data.write(to: url, options: [.atomic])
        }
        
    }
    
    func image(forKey key: String) -> UIImage? {
       // return cache.object(forKey: key as NSString)
        if let existingImage = cache.object(forKey: key as NSString){
            return existingImage
        }
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
        
        
    }
    
    func deletImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
         try FileManager.default.removeItem(at: url)
        } catch let deleteError {
            print("Error removing the image from the disk: \(deleteError)")
        }
    }
    
    func imageURL(forKey key: String) -> URL {
        
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
        
        
        
    }
    
}
