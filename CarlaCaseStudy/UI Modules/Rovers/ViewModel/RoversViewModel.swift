//
//  RoversViewModel.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import Foundation

class RoversViewModel {
    
    private(set) var rovers: [Rover] = []
    private(set) var latestPhotoUrls: [String: String] = [:]
    
    var onRoversFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchRovers() {
        NetworkManager.shared.fetchRovers { result in
            switch result {
            case .success(let rovers):
                self.rovers = rovers
                self.setCustomPhotoUrlsForRovers()
            case .failure(let error):
                self.onError?("Failed to fetch rovers: \(error.localizedDescription)")
            }
        }
    }
    
    private func setCustomPhotoUrlsForRovers() {
        for rover in rovers {
            if let photoUrl = NetworkManager.shared.fetchImageURL(for: rover.name) {
                self.latestPhotoUrls[rover.name] = photoUrl
            } else {
                self.fetchLatestPhotos(for: rover.name)
            }
        }
        self.onRoversFetched?()
    }
    
    private func fetchLatestPhotos(for roverName: String) {
        NetworkManager.shared.fetchLatestPhotos(for: roverName) { result in
            switch result {
            case .success(let photos):
                if let latestPhoto = photos.last {
                    self.latestPhotoUrls[roverName] = latestPhoto.imgSrc
                }
            case .failure(let error):
                self.onError?("Failed to fetch latest photos for rover \(roverName): \(error.localizedDescription)")
            }
        }
    }
}

