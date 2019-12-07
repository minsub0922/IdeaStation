//
//  JsonParser.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/12/07.
//  Copyright © 2019 최민섭. All rights reserved.
//
import Foundation

enum ResultError: Error {
    case nilValue
    case message(String)
}

enum Result<T> {
    case value(T)
    case error(Error)
    
    init(_ value: T?, error: Error = ResultError.nilValue) {
        if let unwrapped = value {
            self = Result.value(unwrapped)
        } else {
            self = Result.error(error)
        }
    }
}

struct Mock {
    private static func readJSON(fileName: String, completion: (Result<[String: Any]>) -> Void) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            completion(Result.error(ResultError.message("Can't find filePath for \(fileName)")))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            completion(Result.value(json as? [String: Any] ?? [:]))
        } catch let e {
            completion(Result.error(e))
        }
    }
    
    private static func readDecodable<T: Decodable>(from json: Result<[String: Any]>, completion: @escaping (Result<T>) -> Void) {
        switch json {
        case .value(let value):
            do {
//                guard let result = value["clusters"] as? [String: Any] else {
//                    completion(Result.error(ResultError.message("response conversion 실패!")))
//                    return
//                }
                let data = try JSONSerialization.data(withJSONObject: value, options: [])
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(Result.value(object))
            } catch let e {
                completion(Result.error(e))
            }
            
        case .error(let error):
            completion(Result.error(error))
        }
    }
    
    static func getMockClusters(completion: @escaping (Result<Clusters>) -> Void) {
        readJSON(fileName: "clusters") { data in
            readDecodable(from: data, completion: { response in
                completion(response)
            })
        }
    }
}
