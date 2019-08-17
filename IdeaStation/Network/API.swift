//
//  API.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

class API {
    static let pixabayBaseURL = "https://pixabay.com/api/"
    static let pixabayKey = "12470240-804dc4fdb5874e9b35535d330" //민섭이꼬
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static let getPictures = {
        return pixabayBaseURL
    }
    
    static let getRelatedTexts = {
        return "http://13.124.243.199:5000/search"
    }
}
