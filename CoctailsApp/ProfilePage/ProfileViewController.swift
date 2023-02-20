//
//  ProfileViewController.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit
import KeychainSwift

class ProfileViewController: UIViewController {
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    lazy var profileTitle: UILabel = {
        var title = UILabel()
        title.text = "Profile"
        title.font = UIFont(name: "Avenir Heavy", size: 33)
        return title
    }()
    
    lazy var borderView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.borderView
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = image.frame.width/2
        image.image = UIImage(systemName: "person.circle.fill")
        image.tintColor = UIColor.borderView
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
        let textField = UITextField()
        textField.placeholder = "Email:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.registerBack
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    lazy var dateOfBirthInformation: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Date Of Birth:  xx/xx/xxxx"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.registerBack
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    lazy var adressInformation: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Addres:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.registerBack
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    var registerUser: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = UIColor.tabBarItemAccent
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.addTarget(
            self, action: #selector(registerUserTapped(_:)),
            for: .touchUpInside
        )
        return button
    }()
    
    var logIn: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = UIColor.tabBarItemAccent
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.addTarget(
            self, action: #selector(logInUserTapped(_:)),
            for: .touchUpInside
        )
        return button
    }()
    
    var clear: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = UIColor.tabBarItemAccent
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.addTarget(
            self, action: #selector(clearUserTapped(_:)),
            for: .touchUpInside
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.profileBack
        setUpUI()
    }
    
    func saveUserDefaultManager() {
        guard let email = emailInformation.text else { return }
        guard let dateOfBirth = dateOfBirthInformation.text else { return }
        guard let adress = adressInformation.text else { return }
        
        UserDefaultManager.shared.save(email, for: .email)
        let readEmail = UserDefaultManager.shared.string(for: .email)
        print("Email is saved to UserDefault: \(readEmail)")
        UserDefaultManager.shared.save(dateOfBirth, for: .dateOfBirth)
        let readDataOfBirth = UserDefaultManager.shared.string(for: .dateOfBirth)
        print("Date of Birth is saved to UserDefault: \(readDataOfBirth)")
        UserDefaultManager.shared.save(adress, for: .adress)
        let readAdress = UserDefaultManager.shared.string(for: .adress)
        print("Adress is saved to UserDefault: \(readAdress)")
    }
    
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
    }
    
    private func setUpSubviews() {
        view.addSubview(profileTitle)
        view.addSubview(borderView)
        view.addSubview(logIn)
        view.addSubview(profileImage)
        view.addSubview(usernameLabel)
        view.addSubview(emailInformation)
        view.addSubview(dateOfBirthInformation)
        view.addSubview(adressInformation)
        view.addSubview(registerUser)
        view.addSubview(clear)
    }
    
    private func setUpConstraints() {
        borderView.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(150)
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
            maker.top.equalToSuperview().offset(100)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(100)
            maker.height.equalTo(40)
        }
        
        profileImage.snp.makeConstraints{ maker in
            maker.top.equalTo(borderView.snp.bottom).offset(50)
            maker.left.equalToSuperview().offset(30)
            maker.width.height.equalTo(188)
        }
        
        usernameLabel.snp.makeConstraints{ maker in
            maker.top.equalTo(borderView).offset(110)
            maker.left.equalTo(profileImage.snp.right).offset(15)
            maker.width.equalTo(115)
            maker.height.equalTo(110)
        }
        
        emailInformation.snp.makeConstraints{ maker in
            maker.top.equalTo(usernameLabel.snp.bottom).offset(65)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(310)
            maker.height.equalTo(45)
        }
        
        dateOfBirthInformation.snp.makeConstraints{ maker in
            maker.top.equalTo(emailInformation.snp.bottom).offset(25)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(310)
            maker.height.equalTo(45)
        }
        
        adressInformation.snp.makeConstraints{ maker in
            maker.top.equalTo(dateOfBirthInformation.snp.bottom).offset(25)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(310)
            maker.height.equalTo(110)
        }
        
        registerUser.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(110)
            maker.right.equalToSuperview().offset(-20)
            maker.width.equalTo(140)
            maker.height.equalTo(30)
        }
        
        logIn.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(110)
            maker.left.equalToSuperview().offset(30)
            
            maker.width.equalTo(140)
            maker.height.equalTo(30)
        }
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    @objc
    private func logInUserTapped(_ sender: UIButton) {
        if let getEmail = keychain.get(Keys.email) {
            emailInformation.text = getEmail
        }
        
        if let getDateOfBirth = keychain.get(Keys.dateOfBirth) {
            dateOfBirthInformation.text = getDateOfBirth
        }
        
        if let getAdress = keychain.get(Keys.adress) {
            adressInformation.text = getAdress
        }
    }
    
    @objc
    private func registerUserTapped(_ sender: UIButton) {
        let authServiceVC = AuthServiceVC()
        navigationController?.pushViewController(authServiceVC, animated: true)
        saveKeyChainManager()
    }
    
    @objc
    private func clearUserTapped(_ sender: UIButton) {
        if keychain.clear() {
            print("Keychain is cleared")
            emailInformation.text = ""
            dateOfBirthInformation.text = ""
            adressInformation.text = ""
            
        }
    }
}



