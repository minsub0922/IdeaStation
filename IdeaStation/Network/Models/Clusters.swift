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
    
    func related8Clusters() -> [Cluster] {
        return Array(clusters.sorted { $0.correlation > $1.correlation } [0..<8])
    }
    func related8ClustersMDKeywords(subject: MDKeyword = MDKeyword(keyword: "")) -> [MDKeyword] {
        var count = 0
        return related8Clusters().map { a -> MDKeyword in
            count += 1
            return MDKeyword(keyword: a.category,
                             rank: count,
                             history: subject.keyword + " " + subject.history)
        }
    }
    func isCategory(word: String) -> Bool {
        return clusters.filter { $0.category.trim.elementsEqual(word.trim) }.count == 1
    }
    func relatedWords(word: String) -> [WordInfo] {
        return Array(clusters.filter { $0.category.trim.elementsEqual(word.trim) })[0].words.map { $0.word }
    }
    func related8Words(word: String) -> [WordInfo] {
        let words = Array(clusters.filter { $0.category.trim.elementsEqual(word.trim) })[0].words
        return Array(words.map { $0.word }.sorted { $0.correlation > $1.correlation }[0..<8])
    }
    func related8WordsMDKeywords(word: MDKeyword) -> [MDKeyword] {
        var count = 0
        return relatedWords(word: word.keyword).map { a -> MDKeyword in
            count += 1
            return MDKeyword(keyword: a.text,
                             rank: count,
                             history: word.keyword + " " + word.history)
        }
    }
}

struct Cluster: Codable {
    let words: [Word]
    let category: String
    let correlation: Double
    var asWordInfo: WordInfo {
        return WordInfo(text: category, correlation: correlation)
    }
}

struct Word: Codable {
    let word: WordInfo
}

struct WordInfo: Codable {
    let text: String
    let correlation: Double
}
