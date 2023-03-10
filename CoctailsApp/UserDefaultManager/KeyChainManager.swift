////
////  KeyChainManager.swift
////  CoctailsApp
////
////  Created by Eldar on 21/2/23.
////

public struct Keys {
    static let keyPrefix = "user"
    static let email = "email"
    static let dateOfBirth = "dateOfBirth"
    static let adress = "adress"
    static let loginName = "loginName"
    static let password = "password"
}


import Security
import Foundation

final class KeychainManager {
    static let shared = KeychainManager()
    
    private init() { }
    
    enum ObjectKey {
        static let credential = "Credential"
    }
    
    enum KeychainError: Error {
        case failedToSaveData
        case failedToRetrieveData
        case failedToDeleteData
    }
    
    private func query(forKey key: String) -> [CFString: Any] {
        return [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: Bundle.main.bundleIdentifier ?? "",
            kSecAttrAccount: key,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock
        ]
    }
    
    func save<T: Encodable>(_ object: T, forKey key: String) throws {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(object) else {
            throw KeychainError.failedToSaveData
        }
        
        var query = self.query(forKey: key)
        query[kSecValueData] = data
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.failedToSaveData
        }
        print("Succesfully saved in kchmanager: \(object)")
    }

    
    func retrieve(forKey key: String) throws -> String? {
        var query = self.query(forKey: key)
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecReturnData] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status != errSecItemNotFound else { return nil }
        guard status == errSecSuccess else {
            throw KeychainError.failedToRetrieveData
        }
        
        guard let data = result as? Data else {
            throw KeychainError.failedToRetrieveData
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func delete(forKey key: String) throws {
        let query = self.query(forKey: key)
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.failedToDeleteData
        }
    }
}
