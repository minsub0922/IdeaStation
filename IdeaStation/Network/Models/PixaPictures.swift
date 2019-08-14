//
//  PixaPictures.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

struct PixaPictures: Codable {
    let total: Int
    let totalHints: Int
    let hits: [Hit]
    
    struct Hit: Codable {
        let id: Int
        let pageURL: String
    }
}


