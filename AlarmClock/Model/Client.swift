//
//  Client.swift
//  AlarmClock
//
//  Created by Fai Wu on 1/3/20.
//  Copyright © 2020 Fai Wu. All rights reserved.
//

import Foundation

class Client {
    static let shared = Client()
    
    func fetchQuteOfDay (_ completionHandler: @escaping (_ quote:String?, _ author: String? , _ error: NSError? ) -> Void) {
        if let url = URL(string: Constants.QuoteOfDay.url) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request){ (data, response, error) in
                
                func sendError(_ error: String) {
                    print(error)
                     let userInfo = [NSLocalizedDescriptionKey : error]
                    completionHandler(nil, nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
                }
                
                guard (error == nil) else {
                    sendError("There was an error with your request: \(error!)")
                    return
                }
                
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                    sendError("Your request returned a status code other than 2xx!")
                    return
                }
                
                guard let data = data else {
                    sendError("No data was returned by the request!")
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    guard let dictionary = json as? [String: Any] else {
                        sendError("Not able to parse the data")
                        return
                    }
                    
                    guard let contents = dictionary["contents"] as? [String: Any] else {
                        sendError("Cannot find key contents")
                        return
                    }
                    
                    guard let quotes = contents["quotes"] as? [[String: Any]] else {
                        sendError("Cannot find key quotes")
                        return
                    }
                    guard let quoteFirst = quotes.first else {
                        sendError("Cannot extract the first item of array")
                        return
                    }
                    guard let quote = quoteFirst["quote"] as? String else {
                        sendError("Cannot find key quote")
                        return
                    }
                    
                    guard let author = quoteFirst["author"] as? String else {
                        sendError("Cannot find key author")
                        return
                    }
                    completionHandler(quote,author, nil)
                    
                } catch let jsonError {
                    print("Failed to parse JSON properly", jsonError)
                }
            }.resume()
        }
    }
}
