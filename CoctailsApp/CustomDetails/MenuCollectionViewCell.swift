//
//  MenuCollectionViewCell.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit
import Kingfisher

class MenuCollectionViewCell: UICollectionViewCell {
    
    var coctail: Drinks?
    
    static var reuseIdentifier = String(describing: MenuCollectionViewCell.self)
    
    var productImage: UIImageView! = {
        var productImage = UIImageView()
        productImage.contentMode = .scaleAspectFit
        productImage.layer.masksToBounds = true
        productImage.layer.cornerRadius = 40
        productImage.clipsToBounds = true
        return productImage
    }()
    
    var productLabel: UILabel = {
        var productLabel = UILabel()
        productLabel.text = "Fried Rice"
        productLabel.numberOfLines = 0
        productLabel.textAlignment = .center
        productLabel.font = UIFont(name: "Avenir", size: 17)
        return productLabel
    }()
    
    var productBuyButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.buyNow
        button.setTitle("Buy now", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .semibold)
        button.layer.cornerRadius = 5
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.cellBack
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        self.addSubview(productImage)
        self.addSubview(productLabel)
        self.addSubview(productBuyButton)
    }
    
    private func setUpConstraints() {
        productImage.snp.makeConstraints{ maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(10)
            maker.width.height.equalTo(105)
        }
        
        productLabel.snp.makeConstraints{ maker in
            maker.top.equalTo(productImage.snp.bottom).offset(-7)
            maker.centerX.equalTo(productImage)
            maker.width.equalTo(120)
            maker.height.equalTo(50)
        }
        
        productBuyButton.snp.makeConstraints { maker in
            maker.top.equalTo(productLabel.snp.bottom).offset(-10)
            maker.centerX.equalTo(productLabel)
            maker.width.equalTo(80)
            maker.height.equalTo(25)
        }
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    func displayInfo(product: Drinks) {
        coctail = product
        productLabel.text = product.strDrink
        productImage.kf.setImage(with: URL(string: product.strDrinkThumb))
    }
}



