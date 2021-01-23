//
//  UserDefaultsConfig.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 22/01/21.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    
    let key: String
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init(_ key: String) {
        self.key = key
    }

    var wrappedValue: T? {
        get {
            
            if let data = UserDefaults.standard.data(forKey: key), let object = try? decoder.decode(T.self, from: data) {
                return object
            } else if let data = UserDefaults.standard.object(forKey: key) as? T {
                return data
            } else {
                return nil
            }
        }
        set {
            
            if let encodedUser = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encodedUser, forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}

struct UserDefaultsConfig {

    @UserDefault("code")
    static var code: String?
    
    @UserDefault("token")
    static var token: String?
    
}
