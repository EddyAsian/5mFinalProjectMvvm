//
//  CoctailsMenuViewModel.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//

import Foundation

class CoctailsMenuViewModel {
    
    let networkManager = NetworkLayer.shared
    var coctailsArray = [Drinks]()
    
    func fetchCoctailsData() async throws -> [Drinks] {
        coctailsArray = try await networkManager.fetchAllCoctailsData().drinks!
        print(coctailsArray)
        return coctailsArray
    }
    
    func returnCoctail(at index: Int) -> Drinks {
        return coctailsArray[index]
    }
    
    func returnCoctailsCount() -> Int {
        return coctailsArray.count
    }
}
