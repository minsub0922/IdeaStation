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
    var selectedDataset: [String] = []
    var dataSetIndex: Int {
        switch selectedDataset.count {
        case 1:
            if selectedDataset.contains("WIKI") {
                return 0
            } else if selectedDataset.contains("NEWS") {
                return 1
            } else {
                return 2
            }
        case 2:
            if selectedDataset.contains("WIKI") && selectedDataset.contains("NEWS") {
                return 3
            } else if selectedDataset.contains("WIKI") && selectedDataset.contains("KIPRIS") {
                return 4
            } else {
                return 5
            }
        case 3:
            return 6
        default:
            return 4
        }
    }
}

//0 : wiki
//1 : news
//2: kipris
//3 : wiki+news
//4 : wiki+kipris
//5 : news+kipris
//6 : all
