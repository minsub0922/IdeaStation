//
//  PostResponse.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/16.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

struct PostResponse {
    let description: String
    let title: String
    let type: Int
    
    func getDictionary() -> [String : Any] {
        return [
            "description": description,
            "title": title,
            "type": type
        ]
    }
}

struct PostData: Codable {
    let description: String?
    let title: String?
    let type: Int?
}
