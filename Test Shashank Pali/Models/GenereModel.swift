//
//  GenereModel.swift
//  Test Shashank Pali
//
//  Created by Shank on 24/06/20.
//  Copyright © 2020 Shank. All rights reserved.
//

import UIKit

class GenereModel: NSObject {
    
    var status = ""
    var title = ""
    var imgURL = ""
    var size = ""
    var id = 0
    
    override init() {
        super.init()
    }
    
    init(response: [String: Any]) {
        super.init()
        let obj = response as Dictionary
        status = obj["status"] as? String ?? ""
        title = obj["dateTime"] as? String ?? ""
        imgURL = obj["thumbnail"] as? String ?? ""
        size = obj["fileSize"] as? String ?? ""
        id = obj["id"] as? Int ?? 0
    }
    
}
