//
//  ViewController.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import UIKit

class ViewController: UIViewController {

    var rovers: [Rover] = []
    var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRoverTest()
        fetchRoverDetailTest()
    }
    
    func fetchRoverTest() {
        NetworkManager.shared.fetchRovers { result in
            switch result {
            case .success(let rovers):
                self.rovers = rovers
                print(rovers)
            case .failure(let error):
                print("Failed to fetch rovers: \(error.localizedDescription)")
            }
        }
    }

    func fetchRoverDetailTest() {
        NetworkManager.shared.fetchLatestPhotos(for: "Curiosity") { result in
            switch result {
            case .success(let photos):
                self.photos = photos
                print(photos)
            case .failure(let error):
                print("Failed to fetch rovers: \(error.localizedDescription)")
            }
        }
    }

}

