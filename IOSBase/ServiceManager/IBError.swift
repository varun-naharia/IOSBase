//
//  IBError.swift
//  IOSBase
//
//  Created by Dinesh Saini on 7/29/17.
//  Copyright © 2017 Dinesh. All rights reserved.
//

import Foundation

class IBError : NSObject{
    
    var requestID  : String = ""
    var requestUrl  : String = ""
    var errorCode   : String = ""
    var message     : String = ""
    var userInfo    = [String : Any]()
    
}
