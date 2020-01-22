//
//  PersistencePixabayLabTests.swift
//  PersistencePixabayLabTests
//
//  Created by Kelby Mittan on 1/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import XCTest
import NetworkHelper

@testable import PersistencePixabayLab

class PersistencePixabayLabTests: XCTestCase {

    func testPixCount() {
        let exp = XCTestExpectation(description: "searches found")
        let pixEndpointURL = "https://pixabay.com/api/?key=\(APIKey.key)&q=mountains&image_type=photo"
        let request = URLRequest(url: URL(string: pixEndpointURL)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("\(appError)")
            case .success(let data):
                do {
                    let searchHits = try JSONDecoder().decode(PixSearch.self, from: data)
                    let pixHits = searchHits.hits
                    XCTAssertEqual(pixHits.count, 20, "should be 20")
                } catch {
                    XCTFail()
                }
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 5.0)
    }

}
