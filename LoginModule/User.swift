//
//  User.swift
//  LoginModule
//
//  Created by Rahul Thakor on 20/05/16.
//  Copyright © 2016 Rahul Thakor. All rights reserved.
//

import UIKit

class User {
    
    var isLoggedIn:Bool?
    func loginUser(username : String , authenticationCode : Bool) ->Bool{
        if authenticationCode {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(username, forKey: "userName")
            defaults.setBool(true, forKey: "authenticatedUser")
            defaults.setObject(NSDate(), forKey: "loginTime")
        }
        return authenticationCode
    }
    
    func logoutUser(){
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("authenticatedUser") {
            defaults.setBool(false, forKey: "authenticatedUser")
            defaults.setObject(NSDate(), forKey: "lastLogout")
        }
    }
}
