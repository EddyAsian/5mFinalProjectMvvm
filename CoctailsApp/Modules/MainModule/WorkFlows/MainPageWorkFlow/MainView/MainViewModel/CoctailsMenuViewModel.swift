//
//  CocktailsMenuViewModel.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import Foundation

class CocktailsMenuViewModel {
    enum ArrivedData {
        case drinksByLetter
        case drinksByName
    }
    private var networkManager: NetworkManager
    
    private var currentLetter: String
    private var currentLetterUnicodeValue: UInt32 = 97 {
        didSet {
            let scalar = UnicodeScalar(currentLetterUnicodeValue)!
            currentLetter = String(scalar)
        }
    }

    init () {
        self.networkManager = NetworkManager.shared
        currentLetter = "a"
    }
    
    public var reloadDrinksCollectionView: (() -> Void)?
    public var showErrorAlert: ((String) -> Void)?
    public var dataFoundWithName:((Bool) -> Void)?
    
    public var drinks = [Drinks]() {
        didSet {
            filteredDrinks = drinks
        }
    }
    
    private var drinkCellViewModels = [CocktailsCellViewModel]() {
        didSet {
            filteredDrinksCellViewModels = drinkCellViewModels
        }
    }
    
    public var filteredDrinks = [Drinks]() {
        didSet {
            dataFoundWithName?(!filteredDrinks.isEmpty)
        }
    }
    
    private var filteredDrinksCellViewModels = [CocktailsCellViewModel]() {
        didSet {
            reloadDrinksCollectionView?()
        }
    }
    
    public func getDrinksWithLetter() {
        Task {
            do {
                let model = try await networkManager.fetchCocktailsWithLetter(currentLetter)
                fetchData(
                    drinks: model.drinks ?? [],
                    dataType: .drinksByLetter
                )
            } catch {
                showErrorAlert?(error.localizedDescription)
            }
        }
    }
    
    private func fetchData(drinks: [Drinks], dataType: ArrivedData) {
        var viewModels = [CocktailsCellViewModel]()
        for drink in drinks {
            viewModels.append(createCellModel(drink: drink))
        }
        switch dataType {
        case .drinksByLetter:
            self.drinks.append(contentsOf: drinks)
            drinkCellViewModels.append(contentsOf: viewModels)
        case .drinksByName:
            filteredDrinks = drinks
            filteredDrinksCellViewModels = viewModels
        }
    }
    
    private func createCellModel(drink: Drinks) -> CocktailsCellViewModel {
        let name = drink.name
        let image = drink.image
        return CocktailsCellViewModel(drinkName: name, image: image)
    }
    
    public func getCellViewModel(at indexPath: IndexPath) -> CocktailsCellViewModel {
        filteredDrinksCellViewModels[indexPath.row]
    }
    
    public func getDrinksWithNextLetter() {
        currentLetterUnicodeValue += 1
        guard currentLetter != "z" else { return }
        getDrinksWithLetter()
    }
    
    public func getDrinksWithName(_ name: String) {
        guard !name.isEmpty else {
            filteredDrinks = drinks
            filteredDrinksCellViewModels = drinkCellViewModels
            return
        }
        Task {
            do {
                let model = try await networkManager.fetchCocktailsWithName(name)
                fetchData(
                    drinks: model.drinks ?? [],
                    dataType: .drinksByName
                )
            } catch {
                showErrorAlert?(error.localizedDescription)
            }
        }
    }
    
}
