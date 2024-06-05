//
//  Rover.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import Foundation

struct Rover: Codable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let cameras: [Camera]
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, cameras
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
    }
}

struct RoversResponse: Codable {
    let rovers: [Rover]
}


