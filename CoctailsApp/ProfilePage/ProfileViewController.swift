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
        textField.backgroundColor = UIColor.profileBack
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    lazy var dateOfBirthInformation: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Date Of Birth:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.profileBack
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    lazy var addressInformation: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Addres:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.profileBack
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.profileBack
        setUpUI()
    }
    
    private func setUpSubviews() {
        view.addSubview(borderView)
        view.addSubview(profileTitle)
        view.addSubview(profileImage)
        view.addSubview(usernameLabel)
        view.addSubview(emailInformation)
        view.addSubview(dateOfBirthInformation)
        view.addSubview(addressInformation)
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
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
}

