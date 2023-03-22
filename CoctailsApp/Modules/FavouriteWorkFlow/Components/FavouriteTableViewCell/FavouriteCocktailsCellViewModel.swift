//
//  File.swift
//  CoctailsApp
//
//  Created by Эльдар on 21/3/23.
//

import UIKit
import Kingfisher

struct FavouriteCocktailsCellViewModel {
    var image: String
    
    public func setImageToImageView(imageView: UIImageView) {
        guard let url = URL(string: image) else {
            print("DrinkCellViewModel. Error. URL is nil. \(image)")
//            imageView.image = UIImage(systemName: "cup.and.saucer.fill")
            return
        }
        imageView.kf.setImage(with: url)
    }
}
