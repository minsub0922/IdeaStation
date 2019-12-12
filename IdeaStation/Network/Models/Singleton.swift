//
//  Singleton.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/12/12.
//  Copyright © 2019 최민섭. All rights reserved.
//
class UserDatas {
    static let shared = UserDatas()
    private init() {}
    var selectedCategory: [String] = []
    var selectedDataset: Int = 4
}
