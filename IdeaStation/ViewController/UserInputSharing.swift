//
//  UserInputSharing.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/18.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

class UserSharingData {
    static let shared = UserSharingData()
    var ideaTitle: String
    var userAnalysisTarget: String
    var userAnalysisCustomer: String
    var userAnalysisUncomfortable: String
    var userAnalysisGain: String
    var userIdeaExplain: String
    
    private init(){
        ideaTitle = ""
        userAnalysisTarget = ""
        userAnalysisCustomer = ""
        userAnalysisUncomfortable = ""
        userAnalysisGain = ""
        userIdeaExplain = ""
    }
}
