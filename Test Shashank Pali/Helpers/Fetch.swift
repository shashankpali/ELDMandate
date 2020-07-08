//
//  Fetch.swift
//  Test Shashank Pali
//
//  Created by Shank on 24/06/20.
//  Copyright © 2020 Shank. All rights reserved.
//

import UIKit

class Fetch: NSObject {
    
    typealias FetchCallback = ([[String: Any]]?, String?) -> Void
    
    static func request(offset: Int, limit: Int, callback: @escaping FetchCallback)  {
        
        var request = URLRequest(url: URL(string: "https://qgkpjarwfl.execute-api.us-east-1.amazonaws.com/dev/getNormalVideoFiles?offset=\(offset)&limit=\(limit)")!,timeoutInterval: Double.infinity)
        request.addValue("jvmNAyPNr1JhiCeUlYmB2ae517p3Th0aGG6syqMb", forHTTPHeaderField: "x-api-key")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            callback(nil, error?.localizedDescription)
            return
          }
            
            let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? Array<[String: Any]>
            callback(obj, nil)
        }

        task.resume()
    }
}
