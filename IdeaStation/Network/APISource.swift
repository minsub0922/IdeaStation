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
    
    func getPicturesPixay(params: Parameters, completion : @escaping (PixaPictures) -> Void) {
        get(API.getPictures(), params: params) { (res: NetworkResult<(Int, PixaPictures)>) in
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
}
