//
//  ProfileViewController.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit
import KeychainSwift

class SignUpViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    lazy var profileTitle: UILabel = {
        var title = UILabel()
        title.text = "Sign Up"
        title.font = UIFont(name: "Avenir Heavy", size: 33)
        return title
    }()
    
    lazy var borderView: UIView = {
        var view = UIView()
        view.backgroundColor = ColorConstants.borderView
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = image.frame.width/2
        image.image = UIImage(systemName: "person.circle.fill")
        image.tintColor = ColorConstants.borderView
        return image
    }()
    
    lazy var usernameLabel: UILabel = {
        var usernameLabel = UILabel()
        usernameLabel.text = "User"
        usernameLabel.font = UIFont(name: "Avenir", size: 33)
        usernameLabel.numberOfLines = 0
        return usernameLabel
    }()
    
    lazy var emailInformation: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Email:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = Constants.cornerRadius
        return textField
    }()
    
    lazy var dateOfBirthInformation: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Date Of Birth:  xx/xx/xxxx"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = Constants.cornerRadius
        return textField
    }()
    
    lazy var adressInformation: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Addres:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = Constants.cornerRadius
        return textField
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
    
    lazy var passwordInformation: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.textContentType = .init(rawValue: "")
        return textField
    }()
    
    var registerUser: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.tabBarItemAccent
        button.setTitle("Accept", for: .normal)
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
    
    //    var logIn: UIButton = {
    //        var button = UIButton(type: .system)
    //        button.backgroundColor = ColorConstants.tabBarItemAccent
    //        button.setTitle("Log in", for: .normal)
    //        button.titleLabel?.textColor = .white
    //        button.setTitleColor(.white, for: .normal)
    //        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    //        button.layer.cornerRadius = Constants.cornerRadius
    //        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
    //        button.layer.shadowOpacity = 0.2
    //        button.addTarget(
    //            self, action: #selector(logInUserTapped),
    //            for: .touchUpInside
    //        )
    //        return button
    //    }()
    
    var clear: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.tabBarItemAccent
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.addTarget(
            self, action: #selector(clearUserTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ColorConstants.profileBack
        setUpUI()
       
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(profileTitle)
        view.addSubview(borderView)
        //        view.addSubview(logIn)
        view.addSubview(profileImage)
        view.addSubview(usernameLabel)
        view.addSubview(emailInformation)
        view.addSubview(dateOfBirthInformation)
        view.addSubview(adressInformation)
        view.addSubview(loginName)
        view.addSubview(passwordInformation)
        view.addSubview(registerUser)
        view.addSubview(clear)
    }
    
    @objc
    private func sighUpTapped(_ sender: UIButton) {
        addNewUser()
        clearKeychain()
        saveKeyChainManager()
//        dismiss(animated: true)
        let addNumberVc = AddNumberViewController()
//        dismiss(animated: false)
        present(addNumberVc, animated: true)
    }
    
    @objc
    private func clearUserTapped(_ sender: UIButton) {
        emailInformation.text = ""
        dateOfBirthInformation.text = ""
        adressInformation.text = ""
        passwordInformation.text = ""
    }
    
    func saveUserDefaultManager() {
        guard let email = emailInformation.text,
              let dateOfBirth = dateOfBirthInformation.text,
              let adress = adressInformation.text,
              let loginName = loginName.text,
              let password = passwordInformation.text else {
            return
        }
        
        let model = UserInfo(email: email, dateOfBirth: dateOfBirth, adress: adress, loginName: loginName, password: password)
        UserDefaultManager.shared.save(model, for: .adress)
        UserDefaultManager.shared.save(model, for: .email)
        UserDefaultManager.shared.save(model, for: .dateOfBirth)
        UserDefaultManager.shared.save(model, for: .loginName)
        
        let readAdress = UserDefaultManager.shared.string(for: .adress)
        print("Adress is saved to UserDefault: \(readAdress)")
        
        let readEmail = UserDefaultManager.shared.string(for: .email)
        print("Email is saved to UserDefault: \(readEmail)")
        
        let readDataOfBirth = UserDefaultManager.shared.string(for: .dateOfBirth)
        print("Date of Birth is saved to UserDefault: \(readDataOfBirth)")
    }
    
    // MARK: -  переделать! как выше
    func saveKeyChainManager() {
        if emailInformation.text != "" {
            guard let email = emailInformation.text else { return }
            keychain.set(email, forKey: Keys.email)
            print("Email is saved to Keychain")
        } else {
            print("Email is not saved to Keychain")
        }
        
        if adressInformation.text != "" {
            guard let adress = adressInformation.text else { return }
            keychain.set(adress, forKey: Keys.adress)
            print("Adress is saved to Keychain")
        }
        
        if dateOfBirthInformation.text != "" {
            guard let dateOfBirth = dateOfBirthInformation.text else { return }
            keychain.set(dateOfBirth, forKey: Keys.dateOfBirth)
            print("Date of Birth is saved to Keychain")
        }
        
        if loginName.text != "" {
            guard let loginName = loginName.text else { return }
            keychain.set(loginName, forKey: Keys.loginName)
            print("Login name is saved to Keychain")
        }
        
        if passwordInformation.text != "" {
            guard let password = passwordInformation.text else { return }
            keychain.set(password, forKey: Keys.password)
            print("Password is saved to Keychain")
        }
    }
    
    func clearKeychain() {
        keychain.clear()
        print("Cleared keychain and added New User")
    }
    
    //    @objc
    //    private func logInUserTapped(_ sender: UIButton) {
    //
    //        if passwordLabel.text == keychain.get(Keys.password) {
    //            dismiss(animated: false)
    //            let tabBar = CocktailsTabBarController()
    //            tabBar.modalPresentationStyle = .fullScreen
    //    //        navigationController?.pushViewController(tabBar, animated: true)
    //            present(tabBar, animated: true, completion: nil)
    //            tabBar.selectedIndex = 1
    //        } else {
    //            showPasswordAlert()
    //        }
    //     }
    
    //    private func getKeychain() {
    //        if let getEmail = keychain.get(Keys.email) {
    //            emailInformation.text = getEmail
    //        }
    //
    //        if let getDateOfBirth = keychain.get(Keys.dateOfBirth) {
    //            dateOfBirthInformation.text = getDateOfBirth
    //        }
    //
    //        if let getAdress = keychain.get(Keys.adress) {
    //            adressInformation.text = getAdress
    //        }
    //    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "It's not enough",
            message: "Please, fill up all 5 fields",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    //    private func showPasswordAlert() {
    //        let alert = UIAlertController(
    //            title: "Error",
    //            message: "Password is not correct",
    //            preferredStyle: .alert
    //        )
    //        let okAction = UIAlertAction(title: "OK", style: .cancel)
    //        alert.addAction(okAction)
    //        present(alert, animated: true)
    //    }
    
    //    override func viewDidDisappear(_ animated: Bool) {
    //        self.dismiss(animated: false, completion: nil)
    //    }
    
    func addNewUser() {
        guard !emailInformation.text!.isEmpty,
              !dateOfBirthInformation.text!.isEmpty,
              !adressInformation.text!.isEmpty,
              !loginName.text!.isEmpty,
              !passwordInformation.text!.isEmpty else {
            showAlert()
            return
        }
    }
    
    private func setUpConstraints() {
        borderView.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(120)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340)
            maker.height.equalTo(5)
        }
        
        clear.snp.makeConstraints { maker in
            maker.bottom.equalTo(borderView).offset(50)
            maker.right.equalToSuperview().offset(-20)
            
            maker.width.equalTo(60)
            maker.height.equalTo(30)
        }
        
        profileTitle.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(70)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(200)
            maker.height.equalTo(40)
        }
        
        profileImage.snp.makeConstraints{ maker in
            maker.top.equalTo(borderView.snp.bottom).offset(20)
            maker.left.equalToSuperview().offset(30)
            maker.width.height.equalTo(150)
        }
        
        usernameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(borderView).offset(50)
            maker.left.equalTo(profileImage.snp.right).offset(15)
            maker.width.equalTo(115)
            maker.height.equalTo(110)
        }
        
        emailInformation.snp.makeConstraints { maker in
            maker.top.equalTo(usernameLabel.snp.bottom).offset(30)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(340)
            maker.height.equalTo(45)
        }
        
        dateOfBirthInformation.snp.makeConstraints{ maker in
            maker.top.equalTo(emailInformation.snp.bottom).offset(25)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(340)
            maker.height.equalTo(45)
        }
        
        adressInformation.snp.makeConstraints { maker in
            maker.top.equalTo(dateOfBirthInformation.snp.bottom).offset(25)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(340)
            maker.height.equalTo(45)
        }
        
        loginName.snp.makeConstraints { maker in
            maker.top.equalTo(adressInformation.snp.bottom).offset(25)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(340)
            maker.height.equalTo(45)
        }
        
        passwordInformation.snp.makeConstraints { maker in
            maker.top.equalTo(loginName.snp.bottom).offset(25)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340)
            maker.height.equalTo(45)
        }
        
        registerUser.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(70)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(140)
            maker.height.equalTo(30)
        }
    }
}



