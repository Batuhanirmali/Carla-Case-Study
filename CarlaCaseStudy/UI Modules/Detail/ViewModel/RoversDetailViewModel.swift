//
//  RoversDetailViewModel.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 6.06.2024.
//

import Foundation

class RoversDetailViewModel {
    
    private(set) var roverName: String?
    private(set) var photos: [Photo] = [] {
        didSet {
            self.updateRoverDetails?()
        }
    }
    
    var updateRoverDetails: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(roverName: String) {
        self.roverName = roverName
    }
    
    func fetchLatestPhotos() {
        guard let roverName = roverName else { return }
        NetworkManager.shared.fetchLatestPhotos(for: roverName) { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos.sorted { $0.earthDate > $1.earthDate }
            case .failure(let error):
                self?.onError?("Failed to fetch latest photos for rover \(roverName): \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfCameras() -> Int {
        return photos.first?.rover.cameras.count ?? 0
    }
    
    func numberOfPhotos() -> Int {
        return photos.first?.rover.totalPhotos ?? 0
    }
}

