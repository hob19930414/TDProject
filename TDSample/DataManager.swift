//
//  DataManager.swift
//  TDSample
//
//  Created by Lingfei Gao on 2018/9/22.
//  Copyright © 2018年 Lingfei Gao. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    let testUrl = "http://api.duckduckgo.com/?q=apple&format=json&pretty=1"
    func getJsonFromUrl(completion: @escaping () -> ()){
       // let url = NSURL(string: testUrl)
        var request = URLRequest(url: URL(string: testUrl)!)
        
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            completion()
        }
        
        task.resume()
    }
}
