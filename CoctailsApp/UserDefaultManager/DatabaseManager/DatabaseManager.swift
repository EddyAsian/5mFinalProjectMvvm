//
//  DatabaseManager.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let db = Firestore.firestore()
    
    private init() { }
    
    func setCocktailsToDataBase(
        collection: String,
        document: String,
        withData data: [String: Any]
    ) {
        
        do {
            try db.collection(collection)
                .document(document)
                .setData(data)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
}
