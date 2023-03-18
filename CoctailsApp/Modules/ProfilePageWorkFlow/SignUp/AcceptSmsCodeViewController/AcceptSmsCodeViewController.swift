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

class AcceptSmsCodeViewController: UIViewController {
    
    class var identifier: String { String(describing: self) }
    
    private lazy var viewModel: SignInViewModel = { SignInViewModel() }()
    
    private func initViewModel() {
        viewModel.showAlert = { [weak self] title, message, completion in
            DispatchQueue.main.async {
                self?.showAlert(
                    title: title,
                    message: message,
                    completion: completion
                )
            }
        }
        
        viewModel.goToMainPage = { [weak self] in
            DispatchQueue.main.async {
                self?.dismiss(animated: true)
                
                
                let tabBar = CocktailsTabBarController()
                tabBar.modalPresentationStyle = .fullScreen
                //        navigationController?.pushViewController(tabBar, animated: true)
                self!.present(tabBar, animated: true, completion: nil)
                tabBar.selectedIndex = 1
            }
        }
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? ) {
        let alert = UIAlertController(
            title: title, message:
                message, preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: completion)
    }
    
    lazy var menuPagesHeader: UILabel = {
        var menuPagesHeader = UILabel()
        menuPagesHeader.text = "3-Step Verification"
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
    
    lazy var smsCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Code from SMS:    XXXXXX"
        textField.font = UIFont(name: "Avenir Next", size: 17)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    var signInButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = .gray
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.isEnabled = false
        button.addTarget(
            self, action: #selector(confirmTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ColorConstants.informationView
        initViewModel()
        setUpUI()
        smsCodeTextField.delegate = self
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(menuPagesHeader)
        view.addSubview(borderView)
        view.addSubview(menuPagesDescription)
        view.addSubview(smsCodeTextField)
        view.addSubview(signInButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc
    private func confirmTapped(_ sender: UIButton) {
        viewModel.verifyCodeAndTryToSignIn(smsCode: smsCodeTextField.text)
    }
    
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
        
        smsCodeTextField.snp.makeConstraints{ maker in
            maker.top.equalTo(menuPagesDescription.snp.bottom).offset(100)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(310)
            maker.height.equalTo(45)
        }
        
        signInButton.snp.makeConstraints { maker in
            maker.top.equalTo(smsCodeTextField.snp.bottom).offset(50)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(170)
            maker.height.equalTo(30)
        }
    }
}

extension AcceptSmsCodeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        switch textField {
        case smsCodeTextField:
            signInButton.backgroundColor = ColorConstants.tabBarItemAccent
            signInButton.isEnabled = true
        default: ()
        }
    }
}




