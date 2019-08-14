//
//  Requestable.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkResult<T> {
    case networkSuccess(T)
    case networkError((resCode: Int, msg: String))
    case networkFail
}


protocol Requestable {
    func get<T: Codable>(_ URL: String,
             params: Parameters?,
             completion: @escaping (NetworkResult<(Int, T)>) -> Void)
    
    func post<T: Codable>(_ URL: String,
              params: [String: Any],
              completion: @escaping (NetworkResult<(Int, T)>) -> Void)
}

extension Requestable {
    
    func get<T: Codable>(_ URL: String,
             params: Parameters? = nil,
             completion: @escaping (NetworkResult<(Int, T)>) -> Void) {
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("networking - invalid url")
            return
        }
        
        Alamofire.request(encodedUrl,
                          method: .get,
                          parameters: params).responseData { (res) in
                            switch res.result {
                            case .success:
                                if let value = res.result.value {
                                    let decoder = JSONDecoder()
                                    do {
                                        let resCode = res.response?.statusCode ?? 0
                                        let datas = try decoder.decode(T.self, from: value)
                                        let result = (resCode, datas)
                                        completion(.networkSuccess(result))
                                    } catch {
                                        print("Decoding Err")
                                    }
                                }
                            case .failure(let err):
                                if let error = err as NSError?, error.code == -1009 {
                                    completion(.networkFail)
                                } else {
                                    let resCode = res.response?.statusCode ?? 0
                                    completion(.networkError((resCode, err.localizedDescription)))
                                }
                            }
        }
    }
    
    func post<T: Codable>(_ URL: String,
              params: [String: Any],
              completion: @escaping (NetworkResult<(Int, T)>) -> Void) {
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("networking - invalid url")
            return
        }
        
        Alamofire.request(encodedUrl,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default).responseData { (res) in
                            switch res.result {
                            case .success:
                                if let value = res.result.value {
                                    let decoder = JSONDecoder()
                                    do {
                                        let resCode = res.response?.statusCode ?? 0
                                        let datas = try decoder.decode(T.self, from: value)
                                        let result = (resCode, datas)
                                        completion(.networkSuccess(result))
                                    } catch {
                                        print("Decoding Err")
                                    }
                                }
                            case .failure(let err):
                                if let error = err as NSError?, error.code == -1009 {
                                    completion(.networkFail)
                                } else {
                                    let resCode = res.response?.statusCode ?? 0
                                    completion(.networkError((resCode, err.localizedDescription)))
                                }
                            }
        }
        
    }
    
}

