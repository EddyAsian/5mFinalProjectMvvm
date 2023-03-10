//
//  PostNewDrinkVC.swift
//  CoctailsApp
//
//  Created by Eldar on 19/2/23.
//

import UIKit

class AddDrinkViewController: UIViewController {
    private lazy var viewModel: AddDrinkViewModel = { AddDrinkViewModel() }()
    
    private func initViewModel() {
        viewModel.showAlert = { [weak self] title, message, completion in
            DispatchQueue.main.async {
                self?.showAlert(with: title, message: message, completion: completion)
            }
        }
        
        viewModel.resetTextFields = { [weak self] in
            DispatchQueue.main.async {
                self?.resetTextFields()
            }
        }
    }
    
    private var text: String = "   🍷  🍸  🍹\n If you would like create your own drinks and add it here,\n we will add it to our Firebase data  ❤️ "
 
    lazy var profileTitle: UILabel = {
        var title = UILabel()
        title.text = "Post a new drink"
        title.font = UIFont(name: "Avenir Heavy", size: 33)
        return title
    }()
    
    lazy var borderView: UIView = {
        var view = UIView()
        view.backgroundColor = ColorConstants.borderView
        return view
    }()
    
    lazy var explainingLabel: UILabel = {
        var usernameLabel = UILabel()
        usernameLabel.text = text
        usernameLabel.font = UIFont(name: "Avenir", size: 21)
        usernameLabel.textAlignment = .center
        usernameLabel.numberOfLines = 0
        return usernameLabel
    }()
    
    lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Name:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = Constants.cornerRadius
        return textField
    }()
    
    lazy var descriptionTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Description"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = Constants.cornerRadius
        return textField
    }()
    
    lazy var priceTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Price:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = Constants.cornerRadius
        return textField
    }()
    
    lazy var imageTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Image URL:"
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = ColorConstants.registerBack
        textField.isUserInteractionEnabled = true
        textField.layer.cornerRadius = Constants.cornerRadius
        return textField
    }()
    
    
    var createNewDrink: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.tabBarItemAccent
        button.setTitle("Create", for: .normal)
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5)
        button.layer.shadowOpacity = 0.2
        button.addTarget(
            self, action: #selector(createDrink),
            for: .touchUpInside
        )
        return button
    }()
    
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
        view.addSubview(explainingLabel)
        view.addSubview(nameTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(priceTextField)
        view.addSubview(imageTextField)
        view.addSubview(createNewDrink)
        view.addSubview(clear)
    }
    
    @objc
    private func createDrink(_ sender: UIButton) {
        postNewDrink()
        viewModel.uploadNewDrinkToDatabase(
            name: nameTextField.text,
            description: descriptionTextField.text,
            price: priceTextField.text,
            image: imageTextField.text
        )
    }
    
    @objc
    private func clearUserTapped(_ sender: UIButton) {
        nameTextField.text = ""
        descriptionTextField.text = ""
        priceTextField.text = ""
        imageTextField.text = ""
    }

    private func showAlert() {
        let alert = UIAlertController(
            title: "It's not enough",
            message: "Please, fill up all 4 fields",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func postNewDrink() {
        guard !nameTextField.text!.isEmpty,
              !descriptionTextField.text!.isEmpty,
              !priceTextField.text!.isEmpty,
              !imageTextField.text!.isEmpty else {
            showAlert()
            return
        }
    }
    
    private func showAlert(with title: String, message: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: completion)
    }
    
    private func resetTextFields() {
        [nameTextField, descriptionTextField, priceTextField, imageTextField].forEach { $0.text = "" }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
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
            maker.width.equalTo(340)
            maker.height.equalTo(40)
        }
        
        explainingLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(nameTextField.snp.top).offset(-25)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(340)
            maker.height.equalTo(150)
        }
        
        nameTextField.snp.makeConstraints { maker in
            maker.bottom.equalTo(descriptionTextField.snp.top).offset(-30)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(340)
            maker.height.equalTo(45)
        }
        
        descriptionTextField.snp.makeConstraints{ maker in
            maker.bottom.equalTo(priceTextField.snp.top).offset(-25)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(340)
            maker.height.equalTo(45)
        }
        
        priceTextField.snp.makeConstraints { maker in
            maker.bottom.equalTo(imageTextField.snp.top).offset(-25)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(340)
            maker.height.equalTo(45)
        }
        
        imageTextField.snp.makeConstraints { maker in
            maker.bottom.equalTo(createNewDrink.snp.top).offset(-25)
            maker.left.equalToSuperview().offset(30)
            maker.width.equalTo(340)
            maker.height.equalTo(45)
        }
        
        createNewDrink.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(120)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(140)
            maker.height.equalTo(30)
        }
    }
}




