//
//  ProductViewController.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit
import Kingfisher

class CoctailViewController: UIViewController {
    
    var coctail: Drinks?
    lazy var productImage: UIImageView = {
        var imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: coctail!.strDrinkThumb))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var productsNameView: UIView = {
        var view = UIView()
        view.backgroundColor = .separator
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var productsNameLabel: UILabel = {
        var label = UILabel()
        label.text = String(describing: coctail!.strDrink)
        label.font = UIFont(name: "Avenir Heavy", size: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var informationView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.informationView
        view.layer.cornerRadius = 25
        return view
    }()
    
    lazy var ratingView: RatingCustomView = {
        var view = RatingCustomView()
        return view
    }()
    
    lazy var likedProductIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.circle")
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .white
        imageView.tintColor = UIColor.likedProductIcon
        return imageView
    }()
    
    lazy var descriptionTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "Description"
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = String(describing: coctail!.strInstructions)
        label.font = UIFont(name: "Avenir Next", size: 10)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var latestReviewsTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "Latest Reviews"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Heavy", size: 10)
        label.textAlignment = .right
        label.backgroundColor = .white
        return label
    }()
    
    lazy var reviewsViewFirst: ReviewCustomView = {
        var view = ReviewCustomView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var reviewsViewSecond: ReviewCustomView = {
        var view = ReviewCustomView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var addToBasketButton: AddProductCustomButton = {
        var button = AddProductCustomButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpSubviews() {
        view.addSubview(productImage)
        productImage.addSubview(productsNameView)
        productsNameView.addSubview(productsNameLabel)
        view.addSubview(informationView)
        informationView.addSubview(ratingView)
        informationView.addSubview(likedProductIcon)
        informationView.addSubview(descriptionTitleLabel)
        informationView.addSubview(descriptionLabel)
        informationView.addSubview(latestReviewsTitleLabel)
        informationView.addSubview(reviewsViewFirst)
        informationView.addSubview(reviewsViewSecond)
        informationView.addSubview(addToBasketButton)
    }
    
    private func setUpConstraints() {
        productImage.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.height.equalTo(500)
        }
        
        productsNameView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(80)
            maker.left.equalToSuperview().offset(250)
            maker.width.equalTo(135)
            maker.height.equalTo(35)
        }
        
        productsNameLabel.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
        }
        
        informationView.snp.makeConstraints { maker in
            maker.top.equalTo(productImage.snp.bottom).inset(30)
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(-25)
            maker.left.equalToSuperview().offset(15)
            maker.width.equalTo(170)
            maker.height.equalTo(50)
        }
        
        likedProductIcon.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(-25)
            maker.left.equalTo(informationView.snp.right).inset(70)
            maker.width.height.equalTo(40)
        }
        
        descriptionTitleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(ratingView.snp.bottom).offset(15)
            maker.left.equalToSuperview().offset(25)
            maker.width.equalTo(155)
            maker.height.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(descriptionTitleLabel.snp.bottom)
            maker.left.equalTo(descriptionTitleLabel)
            maker.width.equalTo(140)
            maker.height.equalTo(100)
        }
        
        latestReviewsTitleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(likedProductIcon.snp.bottom).offset(10)
            maker.right.equalTo(likedProductIcon)
            maker.width.equalTo(120)
            maker.height.equalTo(10)
        }
        
        reviewsViewFirst.snp.makeConstraints { maker in
            maker.top.equalTo(latestReviewsTitleLabel.snp.bottom)
            maker.right.equalTo(likedProductIcon)
            maker.width.equalTo(120)
            maker.height.equalTo(50)
        }
        
        reviewsViewSecond.snp.makeConstraints { maker in
            maker.top.equalTo(reviewsViewFirst.snp.bottom).offset(10)
            maker.right.equalTo(likedProductIcon)
            maker.width.equalTo(120)
            maker.height.equalTo(50)
        }
        
        addToBasketButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(100)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(320)
            maker.height.equalTo(60)
        }
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
}
