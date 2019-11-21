//
//  Cluters.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/21.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

struct Clusters: Codable {
    let n_cluster: Int
    let clusters: [Cluster]
    
    func getTop8Clusters() -> [Cluster] {
        return Array(clusters.sorted { $0.correlation > $1.correlation } [0..<8])
    }
}

struct Cluster: Codable {
    let words: [Word]
    let category: String
    let correlation: Double
}

struct Word: Codable {
    let word: WordInfo
}

struct WordInfo: Codable {
    let text: String
    let correlation: Double
}
