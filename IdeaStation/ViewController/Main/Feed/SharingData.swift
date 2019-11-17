//
//  SharingData.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/17.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
import Firebase

class SharingData {
    static let shared = SharingData()
    var postResponseArray: [PostResponse]
    var FIRref: DatabaseReference! // database
    var FIRstor: StorageReference! // storage
    private init(){
        postResponseArray = []
        FIRref = Database.database().reference()
        FIRstor = Storage.storage().reference()
    }
}
