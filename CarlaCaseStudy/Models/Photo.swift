//
//  Photo.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id, sol, camera, rover
        case imgSrc = "img_src"
        case earthDate = "earth_date"
    }
}

struct LatestPhotosResponse: Codable {
    let latestPhotos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case latestPhotos = "latest_photos"
    }
}
