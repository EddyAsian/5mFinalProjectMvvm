//
//  UserDefaultManager.swift
//  CoctailsApp
//
//  Created by Eldar on 19/2/23.
//


import Foundation

class UserDefaultManager {
    
    enum Storage: String {
        case email
        case dateOfBirth
        case adress
    }
    
    static let shared = UserDefaultManager()
    
    private init() { }
    
    
    func save(_ model: String, for key: Storage) {
        UserDefaults.standard.set(model, forKey: key.rawValue)
    }
    
    func remove(with key: Storage) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    func string(for key: Storage) -> String {
        UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
}

