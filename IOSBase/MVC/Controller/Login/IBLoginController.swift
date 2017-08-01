//
//  IBLoginController.swift
//  IOSBase
//
//  Created by Dinesh Saini on 7/25/17.
//  Copyright © 2017 Dinesh. All rights reserved.
//

import UIKit
import GameplayKit

class IBLoginController: IBBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        #if DEVELOPMENT
            print("Running in development mode")
            
        #else
            print("Running in release mode")
        #endif
        didLoginUser()
        print(AppURL.BaseURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Update UI when reachability change
    override func reachabilityChanged(notification: Notification) {
        let currentReachability : Reachability = notification.object as! Reachability
        let netstatus = currentReachability.currentReachabilityStatus()
        let nnview = NoInternetView.loadFromXIB()
        nnview.tag = AppViewTags.NoInternetViewTag
        switch netstatus {
            
        case NotReachable:
            // Show no internet view
            nnview.frame = self.view.frame
            self.view.addSubview(nnview)

            break
        case ReachableViaWiFi, ReachableViaWWAN:
            // check no network view is alread added on view
            if view.subviews.contains(view.viewWithTag(AppViewTags.NoInternetViewTag)!){
                view.viewWithTag(AppViewTags.NoInternetViewTag)!.removeFromSuperview()
            }
            
            // call your webservice here
            
            break
        default:
            break
        }
    }
    
}


extension IBLoginController{
    
    func didLoginUser() -> Void {
        let reqID = GKRandomSource.sharedRandom().nextInt()
        print(reqID)
        ServiceManager.postRequest(path: "", parameters: [ : ], requestID: reqID, headers: nil) { (status, response, rID) in
            print(rID)
        }
        
        
        let reqID1 = GKRandomSource.sharedRandom().nextInt()
        print(reqID1)
        ServiceManager.postRequest(path: "", parameters: [ : ], requestID: reqID1, headers: nil) { (status, response, rID) in
            print(rID)
        }
    }
}
