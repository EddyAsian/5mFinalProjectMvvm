//
//  ProfileViewController.swift
//  CoctailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
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
    
    lazy var addressInformation: UITextField = {
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
        button.addTarget(self, action: #selector(registerUserTapped(_:)), for: .touchUpInside)
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
        guard let adress = addressInformation.text else { return }
        
        UserDefaultManager.shared.save(email, for: .email)
        print("Email is saved")
        UserDefaultManager.shared.save(dateOfBirth, for: .dateOfBirth)
        print("Date of Birth is saved")
        UserDefaultManager.shared.save(adress, for: .adress)
        print("Adress is saved")
    }
    
    func saveKeyChainManager() {
        guard let email = emailInformation.text else { return }
        guard let dateOfBirth = dateOfBirthInformation.text else { return }
        guard let adress = addressInformation.text else { return }
        
        let service = "thecocktaildb.com"
        let account = "User"
        let emailData = Data(email.utf8)
        let dateOfBirthData = Data(dateOfBirth.utf8)
        let adressData = Data(adress.utf8)
        KeyChainManager.shared.save(emailData, service: service, account: account)
        KeyChainManager.shared.save(dateOfBirthData, service: service, account: account)
        KeyChainManager.shared.save(adressData, service: service, account: account)
    }
    
    private func setUpSubviews() {
        view.addSubview(borderView)
        view.addSubview(profileTitle)
        view.addSubview(profileImage)
        view.addSubview(usernameLabel)
        view.addSubview(emailInformation)
        view.addSubview(dateOfBirthInformation)
        view.addSubview(addressInformation)
        view.addSubview(registerUser)
    }
    
    private func setUpConstraints() {
        borderView.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(150)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340)
            maker.height.equalTo(5)
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
        
        addressInformation.snp.makeConstraints{ maker in
            maker.top.equalTo(dateOfBirthInformation.snp.bottom).offset(25)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(310)
            maker.height.equalTo(110)
        }
        
        registerUser.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(110)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(170)
            maker.height.equalTo(30)
        }
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    @objc
    private func registerUserTapped(_ sender: UIButton) {
        let authServiceVC = AuthServiceVC()
        navigationController?.pushViewController(authServiceVC, animated: true)
    }
}



