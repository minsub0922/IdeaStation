//
//  API.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

class API {
    private static let pixabayBaseURL = "https://pixabay.com/api/"
    static let pixabayKey = "12470240-804dc4fdb5874e9b35535d330" //민섭이꼬
    private static let googlePicturesBaseURL = "https://serpapi.com/search.json"
    static let googleCustomSearchAPI = "AIzaSyB-7pyM5gA5T0mcrRYC2CwRj3plNWxGfgI"
    static let cx = "000918527958296156522:a7pppxbmzt8"
    private static let clusteringAPI = "http://54.180.103.186:8000/clusters/"
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static let getClusters = {
        return clusteringAPI
    }()
    
    static let getPictures = {
        return pixabayBaseURL
    }()
    
    static let getRelatedTexts = {
        //return "http://13.124.243.199:5000/search"
        return "http://54.180.93.206:5000/search"
    }()
    
    static let getGooglePictures = {
        return googlePicturesBaseURL
    }()
    
    static let getIdea = {
        return "http://13.124.243.199:5000/make_idea"
    }
    
    static let getMandalart = {
        return "http://13.124.243.199:5000/mapping"
    }
}
