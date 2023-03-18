
//  WelcomeViewController.swift
//  CoctailsApp
//
//  Created by Eldar on 26/2/23.
//

import UIKit
import KeychainSwift

class WelcomeViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    private var text: String = "Hey there, good to see you again, \n we hope your day will be brighter\n and sunshine with us  ❤️ "
    
    lazy var profileTitle: UILabel = {
        var title = UILabel()
        title.text = "Welcome"
        title.font = UIFont(name: "Avenir Heavy", size: 33)
        title.textAlignment = .center
        return title
    }()
    
    lazy var borderView: UIView = {
        var view = UIView()
        view.backgroundColor = ColorConstants.borderView
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = image.frame.width/0.5
        image.image = UIImage(named: "welcome")
        image.tintColor = ColorConstants.borderView
        return image
    }()
    
    lazy var usernameLabel: UILabel = {
        var usernameLabel = UILabel()
        usernameLabel.text = text
        usernameLabel.font = UIFont(name: "Avenir", size: 21)
        usernameLabel.textAlignment = .center
        usernameLabel.numberOfLines = 0
        return usernameLabel
    }()
    
    lazy var loginName: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Login name:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = Constants.cornerRadius
        return textField
    }()
    
    lazy var passwordLabel: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = Constants.cornerRadius
        return textField
    }()
    
    var registerUser: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = .gray
        button.setTitle("Register", for: .normal)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.addTarget(
            self, action: #selector(sighUpTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    var signIn: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.tabBarItemAccent
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.addTarget(
            self, action: #selector(logInUserTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ColorConstants.profileBack
        setUpUI()
        getKeychain()
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(profileTitle)
        view.addSubview(borderView)
        view.addSubview(loginName)
        view.addSubview(profileImage)
        view.addSubview(usernameLabel)
        view.addSubview(signIn)
        view.addSubview(passwordLabel)
        view.addSubview(registerUser)
    }
    
    @objc
    private func logInUserTapped(_ sender: UIButton) {
        if passwordLabel.text == keychain.get(Keys.password)
            && loginName.text == keychain.get(Keys.loginName) {
            dismiss(animated: true)
            let tabBar = CocktailsTabBarController()
            tabBar.modalPresentationStyle = .fullScreen
            //        navigationController?.pushViewController(tabBar, animated: true)
            present(tabBar, animated: true, completion: nil)
            tabBar.selectedIndex = 1
            
        } else {
            showPasswordAlert()
        }
    }
    
    @objc
    private func sighUpTapped(_ sender: UIButton) {
        dismiss(animated: true)
        let authServiceVC = SignUpViewController()
        present(authServiceVC, animated: true)
    }
    
    private func getKeychain() {
        if let getloginName = keychain.get(Keys.loginName) {
            loginName.text = getloginName
        }
    }
    
    private func showPasswordAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "Password or login is not correct",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func setUpConstraints() {
        borderView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(120)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340)
            maker.height.equalTo(5)
        }
        
        profileTitle.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(70)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340)
            maker.height.equalTo(40)
        }
        
        profileImage.snp.makeConstraints { maker in
            maker.bottom.equalTo(usernameLabel.snp.top).offset(Constants.indent)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340)
            maker.height.equalTo(290)
        }
        
        usernameLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(loginName.snp.top).offset(Constants.indent)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340)
            maker.height.equalTo(110)
        }
        
        loginName.snp.makeConstraints { maker in
            maker.bottom.equalTo(passwordLabel.snp.top).offset(Constants.indent)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340)
            maker.height.equalTo(45)
        }
        
        passwordLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(signIn.snp.top).offset(Constants.indent)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340
            )
            maker.height.equalTo(45)
        }
        
        signIn.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(70)
            maker.left.equalToSuperview().offset(30)
            
            maker.width.equalTo(140)
            maker.height.equalTo(30)
        }
        
        registerUser.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(70)
            maker.right.equalToSuperview().offset(-30)
            maker.width.equalTo(140)
            maker.height.equalTo(30)
        }
    }
}
