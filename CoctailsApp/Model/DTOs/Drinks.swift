//
//  Drinks.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//

import Foundation

struct Coctail: Decodable{
    
    var drinks: [Drinks]?
}

struct Drinks: Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var strInstructions: String
}
