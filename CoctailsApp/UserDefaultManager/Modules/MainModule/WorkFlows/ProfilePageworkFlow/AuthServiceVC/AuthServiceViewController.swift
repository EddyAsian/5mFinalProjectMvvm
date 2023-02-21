//  ViewController.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay
import Firebase
import KeychainSwift
import FirebaseAuth

class AuthServiceViewController: UIViewController {
    
    lazy var menuPagesHeader: UILabel = {
        var menuPagesHeader = UILabel()
        menuPagesHeader.text = "2-Step Verification"
        menuPagesHeader.textAlignment = .center
        menuPagesHeader.font = .systemFont(ofSize: 26, weight: .semibold)
        menuPagesHeader.textColor = .black
        return menuPagesHeader
    }()
    
    lazy var borderView: UIView = {
        var view = UIView()
        view.backgroundColor = ColorConstants.borderView
        return view
    }()
    
    lazy var menuPagesDescription: UILabel = {
        var menuPagesDescription = UILabel()
        menuPagesDescription.text =
        "To finish a registration,\n" + "you will get a message. Please, input six digit numbers from there"
        menuPagesDescription.textAlignment = .center
        menuPagesDescription.font = UIFont(name: "Avenir Next", size: 19)
        menuPagesDescription.textColor = .black
        menuPagesDescription.numberOfLines = 0
        return menuPagesDescription
    }()
    
    lazy var codeInformation: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Code from SMS:    XXXXXX"
        textField.font = UIFont(name: "Avenir Next", size: 17)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    var confirmCode: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.tabBarItemAccent
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.addTarget(
            self, action: #selector(confirmTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private func setUpConstraints() {
        menuPagesHeader.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(100)
            maker.centerX.equalToSuperview()
        }
        
        borderView.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(160)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340)
            maker.height.equalTo(5)
        }
        
        menuPagesDescription.snp.makeConstraints{ maker in
            maker.top.equalTo(borderView.snp.bottom)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(250)
            maker.height.equalTo(150)
        }
        
        codeInformation.snp.makeConstraints{ maker in
            maker.top.equalTo(menuPagesDescription.snp.bottom).offset(100)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(310)
            maker.height.equalTo(45)
        }
        
        confirmCode.snp.makeConstraints { maker in
            maker.top.equalTo(codeInformation.snp.bottom).offset(50)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(170)
            maker.height.equalTo(30)
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ColorConstants.informationView
        setUpUI()
        AuthManager.shared.authentificateWithPN()
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(menuPagesHeader)
        view.addSubview(borderView)
        view.addSubview(menuPagesDescription)
        view.addSubview(codeInformation)
        view.addSubview(confirmCode)
    }
    
    @objc
    private func confirmTapped(_ sender: UIButton) {
        AuthManager.shared.verifyPhoneAuthTapped()
        
        let tabBarController = CocktailsTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
}






