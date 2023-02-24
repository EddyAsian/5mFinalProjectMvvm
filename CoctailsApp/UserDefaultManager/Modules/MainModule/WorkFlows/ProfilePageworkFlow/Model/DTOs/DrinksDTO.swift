//
//  Drinks.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import Foundation

struct Cocktail: Codable{
    
    var drinks: [Drinks]?
}

struct Drinks: Codable {
    var name: String
    var image: String
    var instructions: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case image = "strDrinkThumb"
        case instructions = "strInstructions"
       
    }
    
    var dictionary: [String: Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(
            with: data, options: .mutableContainers
        ) as? [String: Any]) ?? [:]
    }
}
