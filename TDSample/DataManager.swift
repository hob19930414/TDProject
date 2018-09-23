//
//  DataManager.swift
//  TDSample
//
//  Created by Lingfei Gao on 2018/9/22.
//  Copyright © 2018年 Lingfei Gao. All rights reserved.
//

import UIKit
import SwiftyJSON
class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    let testUrl = "http://api.duckduckgo.com/?q=apple&format=json&pretty=1"
    var jsonData = JSON()
    var topicArray =  [[String:String]]()
    func getJsonFromUrl(completion: @escaping () -> ()) {
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
            self.jsonData = JSON(data)
            self.combineTwentyRecords()
            completion()
            }
        
        task.resume()
    }
    
    func combineTwentyRecords() {
        var count = 0
        topicArray = [[String:String]]()
        if jsonData["RelatedTopics"].exists() {
            for topics in jsonData["RelatedTopics"].arrayValue {
                if topics["Topics"].exists() {
                    for topic in topics["Topics"].arrayValue {
                        if let iconDic = topic["Icon"].dictionary {
                            let recordDic = ["text" : topic["Text"].stringValue , "imageURL" : iconDic["URL"]?.stringValue ?? "", "link" : topic["FirstURL"].stringValue]
                            topicArray.append(recordDic)
                            count += 1
                            if count >= 20 {
                                return
                            }
                        }
                    }
                }
                else {
                    if let iconDic = topics["Icon"].dictionary {
                        let recordDic = ["text" : topics["Text"].stringValue , "imageURL" : iconDic["URL"]?.stringValue ?? "", "link" : topics["FirstURL"].stringValue]
                        topicArray.append(recordDic)
                        count += 1
                        if count >= 20 {
                            return
                        }
                    }
                }
            }
        }
    }
}

