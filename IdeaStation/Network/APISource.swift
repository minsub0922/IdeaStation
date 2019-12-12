//
//  ApiSource.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
import Alamofire

struct APISource: APISourceProtocol {
    static let shared = APISource()
    
    private func commonResponseHandler<T>(completion: @escaping (T) -> Void) -> (NetworkResult<(Int, T)>) -> Void {
        return { (res: NetworkResult<(Int, T)>) in
            switch res {
            case .networkSuccess(let data):
                completion(data.1)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail")
            }
        }
    }
    
    func getPicturesPixay(word: String, completion: @escaping (PixaPictures) -> Void) {
        let params = [
            "key": API.pixabayKey,
            "q": word
        ] as Parameters
        
        get(API.getPictures,
            params: params,
            completion: commonResponseHandler(completion: completion))
    }
    
    func getRandomText(word: String, completion: @escaping ([String]) -> Void) {
        let params = [
            "word": word
        ] as Parameters
        get(API.getRelatedTexts,
            params: params,
            completion: commonResponseHandler(completion: completion))
    }
    

    func getPicturesGoogle(word: String, completion: @escaping (GooglePictures) -> Void) {
        let params = [
            "engine": "google",
            "q": word,
            "google_domain": "google.com",
            "tbm": "isch"
        ]
        get(API.getGooglePictures,
            params: params,
            completion: commonResponseHandler(completion: completion))
    }
    
    func getCluster(words: [String], dataSet: Int = 0, completion: @escaping (Clusters) -> Void) {
        let word = words.reduce("") { $0 + $1 + " "}.trim
        let params = [
            "word": word,
            "dataset": dataSet
            ] as [String : Any]
        
//        0 : wiki
//        1 : news
//        2: kipris
//        3 : wiki+news
//        4 : wiki+kipris
//        5 : news+kipris
//        6 : all
        
        get(API.getClusters,
            params: params,
            completion: commonResponseHandler(completion: completion))
    }
    
    
    func getMandalart(words: [String], dataSet: Int = 0, completion: @escaping ([String]) -> Void)  {
        let word = words.reduce("") { $0 + $1 + " "}.trim
        
        let params = [
            "word": word,
            "dataset": dataSet
            ] as [String : Any]
        
        get(API.getMandalart(),
            params: params,
            completion: commonResponseHandler(completion: completion))
    }
    
    func getIdea(words: [String], completion: @escaping ([String]) -> Void)  {
        let word = words.reduce("") { $0 + $1 + " "}.trim
        let params = [
            "word": word
        ]
        get(API.getIdea(),
            params: params,
            completion: commonResponseHandler(completion: completion))
    }
}
