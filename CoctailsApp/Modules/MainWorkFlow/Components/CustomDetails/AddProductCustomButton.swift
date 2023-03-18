//
//  AddProductCustomButton.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit



class AddProductCustomButton: UIButton, UIGestureRecognizerDelegate {
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
    
    private lazy var stepperControl: StepperView = {
        var stepper = StepperView()
        stepper.minimumNumberOfItems = 0
        stepper.additionButtonColor = ColorConstants.tabBarItemAccent
        stepper.decreaseButtonColor = .darkGray
        return stepper
    }()
    
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
        countView.addSubview(stepperControl)
    }
    
    private func setUpConstraints() {
        basketIcon.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().inset(30)
            maker.width.height.equalTo(45)
        }
        
        countView.snp.makeConstraints { maker in
            maker.centerY.centerX.equalToSuperview()
            maker.width.equalTo(85)
            maker.height.equalTo(35)
        }
        
        numberLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().inset(40)
        }
        
        stepperControl.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
            maker.width.equalTo(80)
            maker.height.equalTo(30)
        }
    }
}

