//
//  UserDefaultManager.swift
//  CocktailsApp
//
//  Created by Eldar on 19/2/23.
//


//import Foundation
//
//class UserDefaultManager {
//
//    enum Storage: String {
//        case email
//        case dateOfBirth
//        case adress
//        case loginName
//    }
//
//    static let shared = UserDefaultManager()
//
//    private init() { }
//
//    func save<T: Codable>(_ model: T, for key: Storage) {
//        let encodedData = try! JSONEncoder().encode(model)
//        UserDefaults.standard.set(encodedData, forKey: key.rawValue)
//    }
//
//    func remove(with key: Storage) {
//        UserDefaults.standard.removeObject(forKey: key.rawValue)
//    }
//
//    func string(for key: Storage) -> String {
//        UserDefaults.standard.string(forKey: key.rawValue) ?? ""
//    }
//}


import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    private init() { }

    enum UserDefaultsError: Error {
        case noFoundKeyForObject
        case failedToSaveData
    }
    
    func save<T>(_ object: T, for key: String) throws {
        print("Succesfully saved \(object)!")
        defaults.set(object, forKey: key)
        guard defaults.synchronize() else { throw UserDefaultsError.failedToSaveData }
    }
    
    func retrieve(for key: String) throws -> Any {
        guard let object = defaults.object(forKey: key) else {
            throw UserDefaultsError.noFoundKeyForObject
        }
        return object
    }
    
    func delete(for key: String) {
        defaults.removeObject(forKey: key)
    }
}


