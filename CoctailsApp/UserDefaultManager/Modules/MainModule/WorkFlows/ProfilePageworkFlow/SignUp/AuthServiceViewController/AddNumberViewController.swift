////  ViewController.swift
////  CocktailsApp
////
////  Created by Eldar on 12/2/23.
////
//
//import UIKit
//import SnapKit
////import RxSwift
////import RxRelay
//
//class AddNumberViewController: UIViewController {
//
//    lazy var menuPagesHeader: UILabel = {
//        var menuPagesHeader = UILabel()
//        menuPagesHeader.text = "2-Step Verification"
//        menuPagesHeader.textAlignment = .center
//        menuPagesHeader.font = .systemFont(ofSize: 26, weight: .semibold)
//        menuPagesHeader.textColor = .black
//        return menuPagesHeader
//    }()
//
//    lazy var borderView: UIView = {
//        var view = UIView()
//        view.backgroundColor = ColorConstants.borderView
//        return view
//    }()
//
//    lazy var menuPagesDescription: UILabel = {
//        var menuPagesDescription = UILabel()
//        menuPagesDescription.text =
//        "Please enter your phone number:"
//        menuPagesDescription.textAlignment = .center
//        menuPagesDescription.font = UIFont(name: "Avenir Next", size: 19)
//        menuPagesDescription.textColor = .black
//        menuPagesDescription.numberOfLines = 0
//        return menuPagesDescription
//    }()
//
//    lazy var smsCode: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "+996*********"
//        textField.font = UIFont(name: "Avenir Next", size: 20)
//        textField.borderStyle = .roundedRect
//        textField.backgroundColor = ColorConstants.registerBack
//        textField.isUserInteractionEnabled = true
//        return textField
//    }()
//
//    var acceptNumber: UIButton = {
//        var button = UIButton(type: .system)
//        button.backgroundColor = ColorConstants.tabBarItemAccent
//        button.setTitle("Accept", for: .normal)
//        button.titleLabel?.textColor = .white
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
//        button.layer.cornerRadius = Constants.cornerRadius
//        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
//        button.layer.shadowOpacity = 0.2
//        button.addTarget(
//            self, action: #selector(acceptTapped),
//            for: .touchUpInside
//        )
//        return button
//    }()
//
//    lazy var phoneImage: UIImageView = {
//        var imageView = UIImageView()
//        imageView.image = UIImage(named: "phone")
//        return imageView
//    }()
//
//    override func loadView() {
//        super.loadView()
//        view.backgroundColor = ColorConstants.informationView
//        setUpUI()
//
//    }
//
//    private func setUpUI() {
//        setUpSubviews()
//        setUpConstraints()
//    }
//
//    private func setUpSubviews() {
//        view.addSubview(menuPagesHeader)
//        view.addSubview(borderView)
//        view.addSubview(menuPagesDescription)
//        view.addSubview(smsCode)
//        view.addSubview(acceptNumber)
//        view.addSubview(phoneImage)
//    }
//
//    @objc
//    private func acceptTapped(_ sender: UIButton) {
//        inputPhoneNumber()
//        let authServiceVC = AuthServiceViewController()
////        dismiss(animated: false)
//        present(authServiceVC, animated: true)
//        AuthManager.shared.authentificateWithPN()
//    }
//
//    private func showAlert() {
//        let alert = UIAlertController(
//            title: "Incorrect number",
//            message: "Please input in right format",
//            preferredStyle: .alert
//        )
//        let okAction = UIAlertAction(title: "OK", style: .cancel)
//        alert.addAction(okAction)
//        present(alert, animated: true)
//    }
//
//    func inputPhoneNumber() {
//        guard let sms = smsCode.text, sms.count == 13 else {
//            showAlert()
//            return
//        }
//    }
//
////    override func viewDidDisappear(_ animated: Bool) {
////        self.dismiss(animated: false, completion: nil)
////    }
//
//    private func setUpConstraints() {
//        menuPagesHeader.snp.makeConstraints{ maker in
//            maker.top.equalToSuperview().offset(100)
//            maker.centerX.equalToSuperview()
//        }
//
//        borderView.snp.makeConstraints{ maker in
//            maker.top.equalToSuperview().offset(160)
//            maker.centerX.equalToSuperview()
//            maker.width.equalTo(340)
//            maker.height.equalTo(5)
//        }
//
//        menuPagesDescription.snp.makeConstraints{ maker in
//            maker.top.equalTo(borderView.snp.bottom)
//            maker.centerX.equalToSuperview()
//            maker.width.equalTo(250)
//            maker.height.equalTo(150)
//        }
//
//        smsCode.snp.makeConstraints{ maker in
//            maker.top.equalTo(menuPagesDescription.snp.bottom).offset(100)
//            maker.left.equalToSuperview().offset(30)
//            maker.width.equalTo(310)
//            maker.height.equalTo(45)
//        }
//
//        acceptNumber.snp.makeConstraints { maker in
//            maker.top.equalTo(smsCode.snp.bottom).offset(50)
//            maker.centerX.equalToSuperview()
//            maker.width.equalTo(170)
//            maker.height.equalTo(30)
//        }
//
//        phoneImage.snp.makeConstraints{ maker in
//            maker.centerX.equalToSuperview().inset(0)
//            maker.top.equalTo(acceptNumber.snp.bottom).offset(-450)
//            maker.width.equalTo(700)
//            maker.height.equalTo(1200)
//        }
//    }
//}






//  ViewController.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit
//import RxSwift
//import RxRelay

class AddNumberViewController: UIViewController {
    
    private lazy var viewModel: SignInViewModel = { SignInViewModel() }()
    
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
        "Please enter your phone number:"
        menuPagesDescription.textAlignment = .center
        menuPagesDescription.font = UIFont(name: "Avenir Next", size: 19)
        menuPagesDescription.textColor = .black
        menuPagesDescription.numberOfLines = 0
        return menuPagesDescription
    }()
    
    lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "+996*********"
        textField.font = UIFont(name: "Avenir Next", size: 20)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    var getCodeButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = .gray
        button.setTitle("Send code", for: .normal)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.isEnabled = false
        button.addTarget(
            self, action: #selector(acceptTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    lazy var phoneImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "phone")
        return imageView
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ColorConstants.informationView
        setUpUI()
        phoneNumberTextField.delegate = self
//        acceptNumber.delegate = self
        
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(menuPagesHeader)
        view.addSubview(borderView)
        view.addSubview(menuPagesDescription)
        view.addSubview(phoneNumberTextField)
        view.addSubview(getCodeButton)
        view.addSubview(phoneImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc
    private func acceptTapped(_ sender: UIButton) {
        inputPhoneNumber()
        viewModel.getSMSCode(phoneNumber: phoneNumberTextField.text)
//        smsCodeTextField.isEnabled = true
        let authServiceVC = AuthServiceViewController()
//        dismiss(animated: false)
        present(authServiceVC, animated: true)
//        AuthManager.shared.authentificateWithPN()
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "Incorrect number",
            message: "Please input in right format",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    func inputPhoneNumber() {
        guard let sms = phoneNumberTextField.text, sms.count == 13 else {
            showAlert()
            return
        }
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        self.dismiss(animated: false, completion: nil)
//    }
    
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
        
        phoneNumberTextField.snp.makeConstraints{ maker in
            maker.top.equalTo(menuPagesDescription.snp.bottom).offset(100)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(310)
            maker.height.equalTo(45)
        }
        
        getCodeButton.snp.makeConstraints { maker in
            maker.top.equalTo(phoneNumberTextField.snp.bottom).offset(50)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(170)
            maker.height.equalTo(30)
        }
        
        phoneImage.snp.makeConstraints{ maker in
            maker.centerX.equalToSuperview().inset(0)
            maker.top.equalTo(getCodeButton.snp.bottom).offset(-450)
            maker.width.equalTo(700)
            maker.height.equalTo(1200)
        }
    }
}

extension AddNumberViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        switch textField {
        case phoneNumberTextField:
            getCodeButton.backgroundColor = ColorConstants.tabBarItemAccent
           getCodeButton.isEnabled = true
            
        default: ()
        }
    }
}


