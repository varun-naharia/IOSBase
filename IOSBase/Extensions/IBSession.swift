//
//  IBSession.swift
//  IOSBase
//
//  Created by Dinesh Saini on 7/29/17.
//  Copyright © 2017 Dinesh. All rights reserved.
//

import Foundation


extension URLSession{
    
    func dataTask(with request: URLRequest, requestID : Int, completionHandler: @escaping (Data?, URLResponse?, Error?, _ requestID : Int) -> Void){
        let task = self.dataTask(with: request) { (data, res, error) in
            completionHandler(data, res, error, requestID)
        }
        task.resume()
    }
}
