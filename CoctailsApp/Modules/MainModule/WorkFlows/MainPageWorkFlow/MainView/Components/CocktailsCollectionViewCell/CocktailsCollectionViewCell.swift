//
//  MenuCollectionViewCell.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit
import Kingfisher

class MenuCollectionViewCell: UICollectionViewCell {
    
//    var coctail: Drinks?
    
    class var identifier: String { String(describing: self) }
//    class var nib: UINib { UINib(nibName: identifier, bundle: nil) }
    
    var productImage: UIImageView = {
        var productImage = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 100,
                height: 100
            ))
        productImage.contentMode = .scaleAspectFit
        productImage.layer.masksToBounds = true
        productImage.layer.cornerRadius = 30
        productImage.clipsToBounds = true
        return productImage
    }()
    
    var productLabel: UILabel = {
        var productLabel = UILabel()
        productLabel.text = "Fried Rice"
        productLabel.numberOfLines = 0
        productLabel.textAlignment = .center
        productLabel.font = UIFont(name: "Avenir", size: 17)
        productLabel.numberOfLines = 1
        return productLabel
    }()
    
    var productBuyNowButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.buyNow
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Buy now", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .semibold)
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 7
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
        
        button.addTarget(
            self,
            action: #selector(addToCart),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var stepperControl: StepperView = {
        var stepper = StepperView()
        stepper.minimumNumberOfItems = 0
        stepper.additionButtonColor = UIColor.systemGreen
        stepper.decreaseButtonColor = .darkGray
        return stepper
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ColorConstants.cellBack
        setUpUI()
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        self.addSubview(productImage)
        self.addSubview(productLabel)
        self.addSubview(productBuyNowButton)
        self.addSubview(stepperControl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func addToCart() {
        print("add to cart. buy")
    }
    
    public func configure(with model: Drinks) {
        guard let url = URL(string: model.image) else { return }
        productImage.kf.setImage(with: url)
        productLabel.text = model.name
    }
    
    public var cellViewModel: CocktailsCellViewModel? {
        didSet {
            productLabel.text = cellViewModel?.drinkName
            cellViewModel?.setImageToImageView(imageView: productImage)
        }
    }
    
    //    func chooseCollection(_ product: Drinks) {
    //        coctail = product
    //        let drinks = Drinks(
    //            name: product.name,
    //            image: product.image,
    //            instructions: product.instructions
    //           )
    //
    //        DatabaseManager.shared.setCocktailsToDataBase(
    //            collection: "User",
    //            document: "List of Cocktails",
    //            withData: drinks.dictionary
    //        )
    //    }
    
    //    func displayInfo(product: Drinks) {
    //        coctail = product
    //        productLabel.text = product.name
    //        productImage.kf.setImage(with: URL(string: product.image))
    //        chooseCollection(product)
    //    }
    
    
    //    func displayInfo(product: Drinks) {
    //        coctail = product
    //        productLabel.text = product.name
    //        productImage.kf.setImage(with: URL(string: product.image))
    //        chooseCollection(product)
    //    }
    
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
        
        productBuyNowButton.snp.makeConstraints { maker in
            maker.top.equalTo(productLabel.snp.bottom).offset(-10)
            maker.centerX.equalTo(productLabel)
            maker.width.equalTo(80)
            maker.height.equalTo(25)
        }
        
        stepperControl.snp.makeConstraints { maker in
            maker.centerX.equalTo(productBuyNowButton.snp.right).inset(0)
            maker.top.equalToSuperview().offset(-6)
            maker.width.equalTo(80)
            maker.height.equalTo(24)
        }
    }
}



