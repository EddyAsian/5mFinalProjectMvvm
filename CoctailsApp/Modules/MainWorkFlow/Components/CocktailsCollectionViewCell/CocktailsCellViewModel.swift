//
//  CocktailsCellViewModel.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import Kingfisher

struct CocktailsCellViewModel {
    var drinkName: String
    var image: String
    
    public func setImageToImageView(imageView: UIImageView) {
        guard let url = URL(string: image) else {
            print("DrinkCellViewModel. Error. URL is nil. \(image)")
            imageView.image = UIImage(systemName: "cup.and.saucer.fill")
            return
        }
        imageView.kf.setImage(with: url)
    }
}