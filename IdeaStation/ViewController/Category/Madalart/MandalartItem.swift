//
//  MandalartItem.swift
//  IdeaStation
//
//  Created by 정종인 on 12/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
/*
{
    "mandalartText1":"ex1"
    "mandalartText2":"ex2"
    "mandalartText3":"ex3"
    "mandalartText4":"ex4"
    "mandalartText5":"main sentence"
    "mandalartText6":"ex5"
    "mandalartText7":"ex6"
    "mandalartText8":"ex7"
    "mandalartText9":"ex8"
}
 */

// MARK: 위에꺼처럼 JSON파일 되어있음.
struct MandalartItem: Codable {
    //let mandalartTexts: [String]
    let mandalartText1: String
    let mandalartText2: String
    let mandalartText3: String
    let mandalartText4: String
    let mandalartText5: String
    let mandalartText6: String
    let mandalartText7: String
    let mandalartText8: String
    let mandalartText9: String
}
