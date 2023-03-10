//
//  DatabaseManager.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


//final class DatabaseManager {
//
//    static let shared = DatabaseManager()
//
//    private let db = Firestore.firestore()
//
//    private init() { }
//
//    func setCocktailsToDataBase(
//        collection: String,
//        document: String,
//        withData data: [String: Any]
//    ) {
//
//        do {
//            try db.collection(collection)
//                .document(document)
//                .setData(data)
//        } catch let error {
//            print("Error writing city to Firestore: \(error)")
//        }
//    }
//}


import FirebaseCore
import FirebaseFirestore

public struct DatabaseCollection {
    static let cocktails = "Cocktails"
}

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init () { }
    
    private let db = Firestore.firestore()
    
    public func add(
        to collection: String,
        with data: [String:Any],
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        db.collection(collection).addDocument(data: data) { error in
            guard error == nil else {
                completion( .failure(error!) )
                return
            }
            completion(.success(()))
        }
    }
}
