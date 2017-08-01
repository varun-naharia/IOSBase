//
//  IBBaseController.swift
//  IOSBase
//
//  Created by Dinesh Saini on 7/25/17.
//  Copyright © 2017 Dinesh. All rights reserved.
//

import UIKit

class IBBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Check Network Reachability
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: NSNotification.Name.reachabilityChanged, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc(reachabilityChange:)
    func reachabilityChanged(notification : Notification) -> Void {
        let currentReachability : Reachability = notification.object as! Reachability
        let netstatus = currentReachability.currentReachabilityStatus()
        
        let nnview = NoInternetView.loadFromXIB()
        
        switch netstatus {
            
        case NotReachable:
            // Show no internet view
            nnview.frame = self.view.frame
            self.view.addSubview(nnview)
            
            break
        case ReachableViaWiFi, ReachableViaWWAN:
            if view.subviews.contains(nnview) {
                nnview.removeFromSuperview()
            }

            break
        default:
            break
        }
        
    }
    
}
