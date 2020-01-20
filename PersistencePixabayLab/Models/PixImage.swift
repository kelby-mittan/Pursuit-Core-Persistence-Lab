//
//  PixImage.swift
//  PersistencePixabayLab
//
//  Created by Kelby Mittan on 1/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation

struct PixSearch: Codable {
    let hits: [PixImage]
}

struct PixImage: Codable {
    
    let largeImageURL: String
    let likes: Int
    let id: Int
    let views: Int
    let comments: Int
    let pageURL: String
    let tags: String
    let downloads: Int
    let user: String
    let favorites: Int
    let userImageURL: String
    let previewURL: String
    
}

//"totalHits": 500,
//"hits": [
//    {
//        "largeImageURL": "https://pixabay.com/get/54e0d6424f51a514f6da8c7dda79367a1c3bd7e350586c48702872d19348c75eb0_1280.jpg",
//        "webformatHeight": 360,
//        "webformatWidth": 640,
//        "likes": 2013,
//        "imageWidth": 5184,
//        "id": 2031539,
//        "user_id": 4384506,
//        "views": 748073,
//        "comments": 172,
//        "pageURL": "https://pixabay.com/photos/mountain-landscape-mountains-2031539/",
//        "imageHeight": 2916,
//        "webformatURL": "https://pixabay.com/get/54e0d6424f51a514f6da8c7dda79367a1c3bd7e350586c48702872d19348c75eb0_640.jpg",
//        "type": "photo",
//        "previewHeight": 84,
//        "tags": "mountain landscape, mountains, landscape",
//        "downloads": 467614,
//        "user": "composita",
//        "favorites": 1842,
//        "imageSize": 5575510,
//        "previewWidth": 150,
//        "userImageURL": "https://cdn.pixabay.com/user/2017/03/25/16-58-10-768_250x250.jpg",
//        "previewURL": "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_150.jpg"
//    },
