//
//  GooglePictures.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/19.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

struct GooglePictures: Codable {
    let images_results: [GooglePicture]
}

struct GooglePicture: Codable {
    let position: Int
    let thumbnail: String
    let original: String
    let title: String
    let link: String
    let source: String
}
