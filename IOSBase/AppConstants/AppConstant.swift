//
//  AppConstant.swift
//  IOSBase
//
//  Created by Dinesh Saini on 7/25/17.
//  Copyright © 2017 Dinesh. All rights reserved.
//

import Foundation
import UIKit

struct AppMessage {
    static let MSGNoInternet = "No Internet"
    
}

struct AppColor {
    static let Color_Blue = UIColor.blue
    static let Color_Black = UIColor.black
    static let Color_White = UIColor.white
    static let Color_Green = UIColor.green
    
    
}

struct AppURL {
    
    #if DEVELOPMENT
        static let BaseURL = ""
    #else
        static let BaseURL = ""
    #endif
    
    
    static let Login = ""
    static let Signup = ""
}

struct AppTheme {
    
    func customizeAppTheme() -> Void {
        
        var navigationBarAppearace = UINavigationBar.appearance()
        
        #if DEVELOPMENT
            // set navigation colors, view colors for development app
            navigationBarAppearace.barTintColor = AppColor.Color_Blue
            navigationBarAppearace.tintColor = AppColor.Color_White
            navigationBarAppearace.isTranslucent = false
            navigationBarAppearace.titleTextAttributes = [ NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.white];
            
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        #else
            // set navigation colors, view colors for live app
            navigationBarAppearace.barTintColor = AppColor.Color_Black
            navigationBarAppearace.tintColor = AppColor.Color_White
            navigationBarAppearace.isTranslucent = false
            navigationBarAppearace.titleTextAttributes = [ NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.white];
            
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        #endif
        
    }
}

struct AppFont {
    
}


struct AppStoryboard {
    static let STORYBOARD_MAIN = UIStoryboard(name: "Main", bundle: Bundle.main)
}

struct AppPreferenceKey {
    static let kCurrentUser = "kCurrentUser"
    
}

struct AppViewTags {
    static let NoInternetViewTag = 2000
    
}
