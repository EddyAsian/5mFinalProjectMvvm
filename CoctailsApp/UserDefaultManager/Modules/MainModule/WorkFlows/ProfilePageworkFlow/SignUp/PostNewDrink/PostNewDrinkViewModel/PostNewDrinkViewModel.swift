//
//  PostNewDrinkViewModel.swift
//  CoctailsApp
//
//  Created by Eldar on 19/2/23.
//

import UIKit

final class AddDrinkViewModel {
    private var db: DatabaseManager
    
    init() { self.db = DatabaseManager.shared }
    
    public var showAlert: ((
        String,
        String,
        (() -> Void)?
    ) -> Void)?
    public var resetTextFields: (() -> Void)?
    
    public func uploadNewDrinkToDatabase(
        name: String?,
        description: String?,
        price: String?,
        image: String?
    ) {
        guard
            let name = name, !name.isEmpty,
            let description = description, !description.isEmpty,
            let price = price, !price.isEmpty, let priceDouble = Double(price),
            let image = image, !image.isEmpty
        else {
            showAlert?("Error", "All of the fields must be filled!\nAnd price field must be a number!", nil)
            return
        }
        
        let data: [String:Any] = [
            "Name": name,
            "Description": description,
            "Price": priceDouble,
            "Image": image
        ]
        
        db.add(to: DatabaseCollection.cocktails, with: data) { [weak self] result in
            switch result {
            case .success(()):
                self?.showAlert?(
                    "Success!",
                    "Our congrats! your cocktail is saved ❤️",
                    self?.resetTextFields
                )
            case .failure(let error):
                self?.showAlert?(
                    "Error",
                    error.localizedDescription,
                    nil
                )
            }
        }
    }
}
