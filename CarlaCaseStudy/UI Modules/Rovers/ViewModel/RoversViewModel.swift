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
                self.fetchLatestPhotosForRovers()
            case .failure(let error):
                self.onError?("Failed to fetch rovers: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchLatestPhotosForRovers() {
        let group = DispatchGroup()
        
        for rover in rovers {
            group.enter()
            NetworkManager.shared.fetchLatestPhotos(for: rover.name) { result in
                switch result {
                case .success(let photos):
                    if let latestPhoto = photos.last {
                        self.latestPhotoUrls[rover.name] = latestPhoto.imgSrc
                    }
                case .failure(let error):
                    self.onError?("Failed to fetch latest photos for rover \(rover.name): \(error.localizedDescription)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.onRoversFetched?()
        }
    }
}
