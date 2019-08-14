//
//  API.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

class API {
    static let pixaBayBaseURL = "https://pixabay.com/api/"
    static let pixaBayKey = "12470240-804dc4fdb5874e9b35535d330" //민섭이꼬
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static let getPictures = {
        return pixaBayBaseURL + ""
    }
    
//
//    static let token = {
//        return baseURL + "/token"
//    }()
//
//    //mykeywords/:token
//    static let myKeywordsToken = { (token) in
//        return myKeywords + "/" + token
//    }
//
//    static let myFavoriteList = { (token) in
//        return baseURL + "/worklist/" + token + "/default"
//    }
    
}
