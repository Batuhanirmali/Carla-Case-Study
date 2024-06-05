//
//  NetworkManager.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://mars-photos.herokuapp.com/api/v1/rovers"
    
    private init() {}
    
    func fetchRovers(completion: @escaping (Result<[Rover], Error>) -> Void) {
        let url = baseURL
        AF.request(url).validate().responseDecodable(of: RoversResponse.self) { response in
            switch response.result {
            case .success(let roversResponse):
                completion(.success(roversResponse.rovers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLatestPhotos(for roverName: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let url = "\(baseURL)/\(roverName)/latest_photos"
        AF.request(url).validate().responseDecodable(of: LatestPhotosResponse.self) { response in
            switch response.result {
            case .success(let photosResponse):
                completion(.success(photosResponse.latestPhotos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
