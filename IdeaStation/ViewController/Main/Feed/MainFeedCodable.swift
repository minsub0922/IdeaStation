//
//  MainFeedCodable.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/04.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

struct MainFeed: Codable {
    var type: String
    var context: String
    var imageURL: URL?
    var tag: Int?
}

/*
struct MainSeed: Codable {
    var name: String
    var mainSeedContext: String
    var tag: Int
}

struct MainSprout: Codable {
    var name: String
    var mainSproutContext: String
    var mainSproutImageURL: URL
    var tag: Int
}

struct MainCompetition: Codable {
    var name: String
    var mainCompetitionContext: String
    var mainCompetitionImageURL: URL
    var tag: Int
}
 */
