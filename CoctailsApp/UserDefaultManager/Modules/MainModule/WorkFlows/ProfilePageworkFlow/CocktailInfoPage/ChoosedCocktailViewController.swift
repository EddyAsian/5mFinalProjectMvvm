//
//  ProductViewController.swift
//  CocktailsApp
//
//  Created by Eldar on 12/2/23.
//

import UIKit
import SnapKit
import Kingfisher
import CoreData
import RxRelay



protocol SelecetProductDelegate: AnyObject {
    func addNewDrink(_ drink: Drinks)
}

class ChoosedCocktailViewController: UIViewController {
    
    
    static let id = String(describing: ChoosedCocktailViewController.self)
    
//    public lazy var viewModel = { DrinkInfoViewModel() }()
    class var identifier: String { String(describing: self) }
    class var nib: UINib { UINib(nibName: identifier, bundle: nil) }
    
    
    private var filteredDrinks = [Drinks]()
//    {
//        didSet {
//            updateUIwithSearchResultsState(resultIsEmpty: filteredDrinks.isEmpty)
//            drinksCollectionView.reloadData()
//        }
//    }
    
    private var selectedProirity: String?
    
    public var addNewNote: ((_ ratingNumber: String) -> Void)?
    
    private var cocktailsCoreData: [Cocktails] = []
    var textToShow = ""
    var isLiked: Bool = false
    
    weak var delegate: SelecetProductDelegate?
    
//    private let info: Drinks
//
//    init(dish: Drinks) {
//
//        self.info = dish
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    var addNewNote = { rati}
    
    var food: Drinks?
    
    
    lazy var productImage: UIImageView = {
        var imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: cocktail!.image))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var productsNameView: UIView = {
        var view = UIView()
        view.backgroundColor = .separator
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var productsNameLabel: UILabel = {
        var label = UILabel()
        label.text = String(describing: cocktail!.name)
        label.font = UIFont(name: "Avenir Heavy", size: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var informationView: UIView = {
        var view = UIView()
        view.backgroundColor = ColorConstants.informationView
        view.layer.cornerRadius = 25
        return view
    }()
    
    lazy var ratingView: RatingCustomView = {
        var view = RatingCustomView()
        view.display(item: 32)
        return view
    }()
    
    lazy var likedProductIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .white
        imageView.tintColor = ColorConstants.likedProductIcon
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(likeTap)
        )
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var descriptionTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "Description long text"
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        label.textColor = ColorConstants.description
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = String(describing: cocktail!.instructions)
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var latestReviewsTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "Latest Reviews"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Heavy", size: 11)
        label.textAlignment = .right
        label.backgroundColor = .white
        return label
    }()
    
    lazy var reviewsViewFirst: ReviewCustomView = {
        var view = ReviewCustomView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var reviewsViewSecond: ReviewCustomView = {
        var view = ReviewCustomView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var addToBasketButton: AddProductCustomButton = {
        var button = AddProductCustomButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(
            self, action: #selector(openBasketVc),
            for: .touchUpInside
        )
        return button
    }()
    
    lazy var backImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "back")
        return imageView
    }()
    
    
    
    var cocktail: Drinks?
    
    override func loadView() {
        super.loadView()
        setUpUI()
//        saveToDB()
        fetchSomething()
       
        let backButton = UIBarButtonItem()
        backButton.title = "      "
        backButton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    
    private func saveToDB(_ name: String, _ description: String, _ image: String, _ ratingNumber: String) {
        let cocktail = Cocktails(context: AppDelegate.shared.coreDataStack.managedContext)
        cocktail.setValue(Date(), forKey: #keyPath(Cocktails.dateAdded))
        cocktail.setValue(name, forKey: #keyPath(Cocktails.cocktailsName))
        cocktail.setValue(description, forKey: #keyPath(Cocktails.cocktailsDescription))
        cocktail.setValue(image, forKey: #keyPath(Cocktails.cocktailsImage))
        cocktail.setValue(ratingNumber, forKey: #keyPath(Cocktails.ratingNumber))
        self.cocktailsCoreData.insert(cocktail, at: 0)
        AppDelegate.shared.coreDataStack.saveContext()
        DispatchQueue.main.async {
//            self.tableView.reloadData()
        }
    }
    
    private func fetchSomething() {
        let noteFetch: NSFetchRequest<Cocktails> = Cocktails.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Cocktails.dateAdded), ascending: false)
        noteFetch.sortDescriptors = [sortByDate]
        
        do {
            let managedContext = AppDelegate.shared.coreDataStack.managedContext
            let result = try managedContext.fetch(noteFetch)
            cocktailsCoreData = result
//            tableView.reloadData()
        } catch {
            print("Error is \(error.localizedDescription)")
        }
    }
    
    private func setUpSubviews() {
        view.addSubview(productImage)
        productImage.addSubview(productsNameView)
        productsNameView.addSubview(productsNameLabel)
        view.addSubview(informationView)
        informationView.addSubview(ratingView)
        informationView.addSubview(likedProductIcon)
        informationView.addSubview(descriptionTitleLabel)
        informationView.addSubview(descriptionLabel)
        informationView.addSubview(latestReviewsTitleLabel)
        informationView.addSubview(reviewsViewFirst)
        informationView.addSubview(reviewsViewSecond)
        informationView.addSubview(addToBasketButton)
        informationView.addSubview(backImage)
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func doitman() {
     
        let rating = ratingView.ratingLabel.text
        self.addNewNote = { ratingNumber in
            print(rating)
        }
    }
    
    @objc func likeTap() {
        if isLiked == false {
            likedProductIcon.image = UIImage(systemName: "heart")
            isLiked = true
        } else {
            likedProductIcon.image = UIImage (systemName: "heart.fill")
            doitman()
            guard let rating = ratingView.ratingLabel.text else { return  }
            addNewNote?(rating)
            isLiked = false
            }
     }
    
    
    @objc func openBasketVc() {
//        dismiss(animated: true)
        navigationController?.pushViewController(BasketChoosedViewController(), animated: true)
    }
    @objc func tappedMe() {
//        dismiss(animated: true, completion: nil)
//        let tabBar = CocktailsTabBarController()
//        tabBar.modalPresentationStyle = .fullScreen
//        present(tabBar, animated: true, completion: nil)
//        tabBar.selectedIndex = 3
        
        delegate?.addNewDrink(cocktail!)
        
        guard let foodname = cocktail?.name,
              let foodDescription = cocktail?.instructions else { return }
        
    }
    
    private func setUpConstraints() {
        productImage.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.height.equalTo(500)
        }
        
        productsNameView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(80)
            maker.left.equalToSuperview().offset(250)
            maker.width.equalTo(135)
            maker.height.equalTo(35)
        }
        
        productsNameLabel.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
        }
        
        informationView.snp.makeConstraints { maker in
            maker.top.equalTo(productImage.snp.bottom).inset(30)
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(-25)
            maker.left.equalToSuperview().offset(15)
            maker.width.equalTo(170)
            maker.height.equalTo(50)
        }
        
        likedProductIcon.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(-25)
            maker.left.equalTo(informationView.snp.right).inset(70)
            maker.width.height.equalTo(45)
        }
        
        descriptionTitleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(ratingView.snp.bottom).offset(15)
            maker.left.equalToSuperview().offset(25)
            maker.width.equalTo(155)
            maker.height.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(descriptionTitleLabel.snp.bottom)
            maker.left.equalTo(descriptionTitleLabel)
            maker.width.equalTo(160)
//            maker.height.equalTo(100)
        }
        
        latestReviewsTitleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(likedProductIcon.snp.bottom).offset(10)
            maker.right.equalTo(likedProductIcon)
            maker.width.equalTo(140)
            maker.height.equalTo(20)
        }
        
        reviewsViewFirst.snp.makeConstraints { maker in
            maker.top.equalTo(latestReviewsTitleLabel.snp.bottom)
            maker.right.equalTo(likedProductIcon)
            maker.width.equalTo(140)
            maker.height.equalTo(60)
        }
        
        reviewsViewSecond.snp.makeConstraints { maker in
            maker.top.equalTo(reviewsViewFirst.snp.bottom).offset(10)
            maker.right.equalTo(likedProductIcon)
            maker.width.equalTo(140)
            maker.height.equalTo(60)
        }
        
        addToBasketButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(100)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(320)
            maker.height.equalTo(60)
        }
        
        backImage.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(0)
            maker.top.equalToSuperview().offset(-438)
            maker.width.height.equalTo(105)
        }
     }
}


extension Notification.Name {
    static let reload = Notification.Name("reload")
}


    extension ChoosedCocktailViewController {
//        func collectionView(
//            _ collectionView: UICollectionView,
//            layout collectionViewLayout: UICollectionViewLayout,
//            sizeForItemAt indexPath: IndexPath
//        ) -> CGSize {
//            let cellCustomWidth = (collectionView.bounds.width - 50) / 2
//            return CGSize(width: cellCustomWidth, height: cellCustomWidth + 11)
//        }
        
        func collectionView(
            _ collectionView: UICollectionView,
            didSelectItemAt indexPath: IndexPath
        ) {
            let choosedForBasketVC = BasketViewController()
            let model = filteredDrinks[indexPath.row]
            let observe = BehaviorRelay<Drinks>(value: model)
            observe.subscribe(onNext: { drinks in
                choosedForBasketVC.cocktail = drinks
                print(choosedForBasketVC.cocktail as Any)
            })
//            choosedForBasketVC.delegate = self
            navigationController?.pushViewController(choosedForBasketVC, animated: true)
        }
    }
