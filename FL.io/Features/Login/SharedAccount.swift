//
//  SharedAccount.swift
//  FL.io
//
//  Created by Viorel Porumbescu on 14.04.2021.
//

import Foundation

struct SharedAccount {

    @UserDefault("currentUsername", defaultValue: nil)
    static var username:String?
    
    @UserDefault("currentToken", defaultValue: nil)
    static var token:String?
    
    
    static var isLoggedIn:Bool {
        return username != nil && token != nil
    }
   
    static func clearAccount() {
        username = nil
        token = nil
    }
}
