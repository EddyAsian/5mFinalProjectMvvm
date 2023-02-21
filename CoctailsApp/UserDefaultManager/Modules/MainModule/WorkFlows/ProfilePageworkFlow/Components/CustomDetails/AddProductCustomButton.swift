//
//  AddProductCustomButton.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit

class AddProductCustomButton: UIButton {
    
    lazy var basketIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "trash")
        return imageView
    }()
    
    lazy var numberLabel: UILabel = {
        var label = UILabel()
        label.text = "№500"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var countView: UIView = {
        var view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var countLabel: UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var plusIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy var minusIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "minus")
        imageView.tintColor = .white
        return imageView
    }()
    
    private func setUpConstraints() {
        basketIcon.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().inset(30)
            maker.width.height.equalTo(35)
        }
        
        countView.snp.makeConstraints { maker in
            maker.centerY.centerX.equalToSuperview()
            maker.width.equalTo(75)
            maker.height.equalTo(30)
        }
        
        countLabel.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
            maker.width.height.equalTo(25)
        }
        
        numberLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().inset(20)
        }
        
        plusIcon.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(5)
            maker.width.height.equalTo(15)
        }
        
        minusIcon.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().inset(5)
            maker.width.height.equalTo(15)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ColorConstants.addProduct
        self.layer.cornerRadius = 25
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        self.addSubview(basketIcon)
        self.addSubview(countView)
        self.addSubview(numberLabel)
        countView.addSubview(countLabel)
        countView.addSubview(plusIcon)
        countView.addSubview(minusIcon)
    }
}
