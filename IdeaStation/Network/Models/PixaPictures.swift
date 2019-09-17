//
//  PixaPictures.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

struct PixaPictures: Codable {
//    let total: Int
//    let totalHits: Int
    let hits: [Hit]
}

struct Hit: Codable {
    //        let id: Int
    //        let pageURL: String
    //        let type: String
    //        let tags: String
    let previewURL: String
    //        let previewWidth: Int
    //        let previewHeight: Int
    //        let webformatURL: String
    //        let webformatWidth: Int
    //        let webformatHeight: Int
//            let largeImageURL: String
//            let fullHDURL: String
    //        let imageURL: String
    //        let imageWidth: Int
    //        let imageHeight: Int
    //        let imageSize: Int
    //        let views: Int
    //        let downloads: Int
    //        let favorites: Int
    //        let likes: Int
    //        let comments: Int
    //        let user_id: Int
    //        let user: String
    //        let userImageURL: String
}

