//
//  FullScreenImageViewModel.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 6.06.2024.
//

import Foundation
import SDWebImage

class FullScreenImageViewModel {
    
    var photo: Photo?
    
    func loadPhoto(completion: @escaping (UIImage?) -> Void) {
        guard let photoUrl = URL(string: photo?.imgSrc ?? "") else {
            completion(UIImage(named: "notfound"))
            return
        }
        
        SDWebImageManager.shared.loadImage(with: photoUrl, options: [], progress: nil) { (image, data, error, cacheType, finished, imageUrl) in
            if let error = error {
                print("Failed to load image: \(error)")
                completion(UIImage(named: "notfound"))
            } else {
                completion(image)
            }
        }
    }
}
