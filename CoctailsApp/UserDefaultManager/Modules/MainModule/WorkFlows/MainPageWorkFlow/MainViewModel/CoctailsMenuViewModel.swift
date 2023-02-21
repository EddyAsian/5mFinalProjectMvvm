//
//  CocktailsMenuViewModel.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import Foundation

class CocktailsMenuViewModel {
    
    static let shared = CocktailsMenuViewModel()
    
    private init() { }
    
    let networkManager = NetworkLayer.shared
    var cocktailsArray = [Drinks]()
    
    func fetchCocktailsData() async throws -> [Drinks] {
        cocktailsArray = try await networkManager.fetchAllCocktailsData().drinks!
        print(cocktailsArray)
        return cocktailsArray
    }
    
    func returnCoctail(at index: Int) -> Drinks {
        return cocktailsArray[index]
    }
}
