//
//  NetworkManagerTests.swift
//  CarlaCaseStudyTests
//
//  Created by Talha Batuhan Irmalı on 6.06.2024.
//

import XCTest
import Foundation
@testable import CarlaCaseStudy

class NetworkManagerTests: XCTestCase {
    
    var fakeNetworkManager: FakeNetworkManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeNetworkManager = FakeNetworkManager()
    }

    override func tearDownWithError() throws {
        fakeNetworkManager = nil
        try super.tearDownWithError()
    }

    func testFetchRoversSuccess() throws {
        let expectedRovers = [
            Rover(id: 1, name: "Curiosity", landingDate: "2012-08-06", launchDate: "2011-11-26", status: "active", maxSol: 1000, maxDate: "2022-06-01", totalPhotos: 100, cameras: []),
            Rover(id: 2, name: "Opportunity", landingDate: "2004-01-25", launchDate: "2003-07-07", status: "complete", maxSol: 5000, maxDate: "2018-06-10", totalPhotos: 200, cameras: [])
        ]
        fakeNetworkManager.fetchRoversResult = expectedRovers
        
        let expectation = self.expectation(description: "FetchRovers")
        
        fakeNetworkManager.fetchRovers { result in
            switch result {
            case .success(let rovers):
                XCTAssertEqual(rovers.count, expectedRovers.count)
                XCTAssertEqual(rovers, expectedRovers)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchRoversFailure() throws {
        fakeNetworkManager.shouldReturnError = true
        
        let expectation = self.expectation(description: "FetchRoversFailure")
        
        fakeNetworkManager.fetchRovers { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchLatestPhotosSuccess() throws {
        let expectedRover = Rover(id: 1, name: "Curiosity", landingDate: "2012-08-06", launchDate: "2011-11-26", status: "active", maxSol: 1000, maxDate: "2022-06-01", totalPhotos: 100, cameras: [])
        let expectedPhotos = [
            Photo(id: 1, sol: 100, camera: Camera(name: "FHAZ", fullName: "Front Hazard Avoidance Camera"), imgSrc: "http://example.com/photo1.jpg", earthDate: "2021-06-01", rover: expectedRover),
            Photo(id: 2, sol: 101, camera: Camera(name: "RHAZ", fullName: "Rear Hazard Avoidance Camera"), imgSrc: "http://example.com/photo2.jpg", earthDate: "2021-06-02", rover: expectedRover)
        ]
        fakeNetworkManager.fetchPhotosResult = expectedPhotos
        
        let expectation = self.expectation(description: "FetchLatestPhotos")
        
        fakeNetworkManager.fetchLatestPhotos(for: "Curiosity") { result in
            switch result {
            case .success(let photos):
                XCTAssertEqual(photos.count, expectedPhotos.count)
                XCTAssertEqual(photos, expectedPhotos)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchLatestPhotosFailure() throws {
        fakeNetworkManager.shouldReturnError = true
        
        let expectation = self.expectation(description: "FetchLatestPhotosFailure")
        
        fakeNetworkManager.fetchLatestPhotos(for: "Curiosity") { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class FakeNetworkManager: NetworkManagerProtocol {
    var shouldReturnError = false
    var fetchRoversResult: [Rover] = []
    var fetchPhotosResult: [Photo] = []

    func fetchRovers(completion: @escaping (Result<[Rover], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Fake error"])))
        } else {
            completion(.success(fetchRoversResult))
        }
    }
    
    func fetchLatestPhotos(for roverName: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Fake error"])))
        } else {
            completion(.success(fetchPhotosResult))
        }
    }
    
    func fetchImageURL(for roverName: String) -> String? {
        return "http://example.com/fake_image.jpg"
    }
}
