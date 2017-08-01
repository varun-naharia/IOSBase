//
//  NoInternetView.swift
//  InternetViewApp
//
//  Created by Neeraj Jain on 12/04/17.
//  Copyright © 2017 Neeraj Jain. All rights reserved.
//

import UIKit

class NoInternetView: UIView {

    @IBOutlet weak var lblNoInViewTitle : UILabel!
    @IBOutlet weak var lblNoInViewDescription : UILabel!
    
    @IBOutlet weak var imgView : UIImageView!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func loadFromXIB() -> NoInternetView{
        return Bundle.main.loadNibNamed("NoInternetView", owner: nil, options: nil)!.first as! NoInternetView
    }
    
    @IBAction func retryInternet(_ sender : UIButton) -> Void{
        ReachabilityUtil.reachability { (status) in
            if status != NotReachable{
                self.removeFromSuperview()
            }
        }
    }
}
