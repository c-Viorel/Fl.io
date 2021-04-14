//
//  UserDefaultPropertyWrapper.swift
//  Dynamic Wallpaper
//
//  Created by Viorel Porumbescu on 04/02/2020
//  Copyright © 2019 Minglebit. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T

    public init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

/// Use this property wrapper for custom defined objects
/// TODO: Check if we can merge the two propertyWrappers into one.
@propertyWrapper
public struct UserDefaultCustom<T: Codable> {
    private let key: String
    private let defaultValue: T

    public init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            if let json = UserDefaults.standard.object(forKey: key) as? String,
                let data = json.data(using: .utf8),
                let result = try? JSONDecoder().decode(T.self, from: data) {
                return result
            }
            return defaultValue
        }
        set {
            if let encodedObject = try? JSONEncoder().encode(newValue) {
                let encodedString = String(data: encodedObject, encoding: .utf8)
                UserDefaults.standard.set(encodedString, forKey: key)
            }
        }
    }
}
