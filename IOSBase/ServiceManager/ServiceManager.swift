//
//  ServiceManager.swift
//  IOSBase
//
//  Created by Dinesh Saini on 7/27/17.
//  Copyright © 2017 Dinesh. All rights reserved.
//

import Foundation


struct RequestType {
    static let POST = "POST"
    static let GET = "GET"
}

enum APIStatus {
    case Error
    case Success
}


class ServiceManager  {
    
    class func postRequest(path : String, parameters : [String : Any], requestID : Int, headers : [String : String]?, responseHandler : @escaping (_ status : APIStatus, _ response : Any, _ reuquestID : Int) -> Void) -> Void{
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = TimeInterval(80)
        configuration.timeoutIntervalForResource = TimeInterval(80)
        let session = URLSession(configuration: configuration)
        
        // Check passed parametrs is nil
        var params = [String : Any]()
        if parameters != nil {
            params = parameters
        }
        
        //Url Encoding
        let urlPath = (AppURL.BaseURL+path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        //Create Request
        var request = URLRequest(url: URL(string : urlPath!)!)
        
        //Request Method
        request.httpMethod = RequestType.POST
        
        //Set request header parameters
        if headers != nil{
            request.allHTTPHeaderFields = headers
        }
        request.addValue("SIGNATURE", forHTTPHeaderField: "SIGNATURE")
        request.addValue("IOS_APP", forHTTPHeaderField: "REQUEST_BY")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("text/html", forHTTPHeaderField: "Accept")
        request.addValue(String(requestID), forHTTPHeaderField: "request_id")
        
        //Add request data
        var requestData = Data()
        do {
            requestData = try JSONSerialization.data(withJSONObject: params, options:JSONSerialization.WritingOptions(rawValue: 0))
            request.httpBody = requestData
        } catch  {
            print("Error in converting from Dictionary to Data")
        }
        
        //Print request data in console
        self.printRequestData(request: request)
        
        session.dataTask(with: request, requestID: requestID) { (data, res, error, rid) in
            
            if error != nil{
                let tempError : NSError = error! as NSError
                
                let error = IBError()
                error.errorCode = String(tempError.code)
                error.requestID = String(rid)
                
                switch tempError.code{
                    
                case NSURLErrorUnknown:
                    error.message = String(NSURLErrorUnknown)
                    break
                    
                case NSURLErrorCancelled:
                    error.message = String(NSURLErrorCancelled)
                    break
                    
                case NSURLErrorBadURL:
                    error.message = String(NSURLErrorBadURL)
                    break
                    
                case NSURLErrorTimedOut:
                    error.message = String(NSURLErrorTimedOut)
                    break
                    
                case NSURLErrorUnsupportedURL:
                    error.message = String(NSURLErrorUnsupportedURL)
                    break

                case NSURLErrorCannotFindHost:
                    error.message = String(NSURLErrorCannotFindHost)
                    break

                case NSURLErrorCannotConnectToHost:
                    error.message = String(NSURLErrorCannotConnectToHost)
                    break

                case NSURLErrorResourceUnavailable:
                    error.message = String(NSURLErrorResourceUnavailable)
                    break

                case NSURLErrorNotConnectedToInternet:
                    error.message = String(NSURLErrorNotConnectedToInternet)
                    break
                    
                case NSURLErrorBadServerResponse:
                    error.message = String(NSURLErrorBadServerResponse)
                    break
                    
                case NSURLErrorCannotParseResponse:
                    error.message = String(NSURLErrorCannotParseResponse)
                    break
                    
                case NSURLErrorCallIsActive:
                    error.message = String(NSURLErrorCallIsActive)
                    break
                    
                default:
                    break
                }
                DispatchQueue.main.async {
                    responseHandler(.Error, error, rid)
                }
                
            }
            else{
                var json = JSON.init(data: data!)
                if json == JSON.null{
                    let text = String(data: data!, encoding: .utf8)
                    if (text?.contains("{"))!
                    {
                        let range: Range<String.Index> = text!.range(of: "{")!
//                        let range1: Range<String.Index> = text!.range(of: "}")!
                        let index: Int = text!.distance(from: text!.startIndex, to: range.lowerBound)
                        let resString : NSString = text! as NSString
                        let substr = resString.substring(with: NSMakeRange(index, (text?.characters.count)! - index))
                        
                        let tempStr : String = substr 
                        
                        json = JSON.init(parseJSON: tempStr)
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            // Show alert Data not found
                            let error = IBError()
                            responseHandler(.Error, error, rid)
                        }
                    }
                }
                DispatchQueue.main.async {
                    responseHandler(.Success, json, rid)
                }
                
                self.printResponseData(response: json)
            }
            
        }
    }
    
    
    
    class func printRequestData(request : URLRequest){
        
        #if DEVELOPMENT
            print("Request URL :- \((request.url?.absoluteString)!)")
            print("Request Header Fields :- \((request.allHTTPHeaderFields)!)")
            print("Request Method Type :- \((request.httpMethod)!)")
            
        #else
            //Release mode
        #endif
    }
    
    class func printResponseData(response : Any){
        #if DEVELOPMENT
            print(response)
        #else
            //Release mode
        #endif
    }
}
