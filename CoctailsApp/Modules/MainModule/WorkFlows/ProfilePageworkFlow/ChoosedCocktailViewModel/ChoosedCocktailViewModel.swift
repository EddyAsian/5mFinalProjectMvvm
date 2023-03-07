//
//  ChoosedCocktailViewModel.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//


import Foundation
import Kingfisher

final class ChoosedCocktailViewModel {
    public var drink: Drinks!
    
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
