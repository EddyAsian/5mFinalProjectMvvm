//
//  ChoosedCocktailViewModel.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//


import Foundation
import Kingfisher

protocol LikedDrinksProvider {
    var likedDrinks: [Drinks] { get set }
    func getLikedDrinks() -> [Drinks]

    init()
}

extension LikedDrinksProvider {
    func getLikedDrinks() -> [Drinks] {
        return likedDrinks
    }
}

final class ChoosedCocktailViewModel: LikedDrinksProvider {
    
    var drink: Drinks!
        var likedDrinks: [Drinks] = []
        
        func addLikedDrink() {
            guard let drink = self.drink as? Drinks else {
                return
            }
            likedDrinks.append(drink)
            print("😼\(likedDrinks)")
        }

    func removeLastLikedDrink() {
        guard let drink = self.drink as? Drinks else {
            return
        }
        let removedDrink = likedDrinks.removeLast()
           print("Removed drink: \(likedDrinks)")
    }
    
    public func getDrinkToShow(_ data: Drinks) {
        self.drink = data
    }
    
    public func setImageToImageView(imageView: UIImageView) {
        guard let url = URL(string: drink.image) else {
            print("DrinkCellViewModel. Error. URL is nil. \(drink.image)")
            imageView.image = UIImage(systemName: "cup.and.saucer.fill")
            return
        }
        imageView.kf.setImage(with: url)
    }
}
