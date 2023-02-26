
//
//  MainPageViewController.swift
//  cocktailsApp
//
//  Created by Eldar on 19/2/23.
//

import UIKit
import SnapKit
import RxRelay

class FavouriteDrinksViewController: UIViewController {
   
    private var viewModel: MainViewModelType = MainViewModel()
    
    // For requesting to API to get next letter's drinks
    private var currentLetterUnicodeVoralue: UInt32 = 97
    private var currentLetter = "a"
    
    //    var cocktail: Drinks?
    
    private var notificationArray = [Drinks]()
    
    private var drinks = [Drinks]() {
        didSet {
            filteredDrinks = drinks
        }
    }
    
    // MARK: Subviews creating
    private lazy var allDrinksTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Favourite ❤️"
        label.font = UIFont(name: "Avenir Next Bold", size: 26)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pageInfoSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cehck your choosed drinks\n and we will deliver them."
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Roman", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // UISearchBar for searching drink by name.
    private lazy var searchDrinkSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search nice drink"
        searchBar.searchTextField.font = UIFont(name: "Avenir-Roman", size: 17)
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = ColorConstants.background
        searchBar.searchTextField.backgroundColor = .white
        searchBar.enablesReturnKeyAutomatically = false
        
        // Shadow configuration
        searchBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        searchBar.layer.shadowOpacity = 1
        searchBar.layer.shadowRadius = 4
        searchBar.layer.masksToBounds = false
        
        return searchBar
    }()
    
    // Background view for UICollectionView creating
    private lazy var backgroundViewForCollection: UIView = {
        let view = UIView()
        view.backgroundColor = ColorConstants.cellBack
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    private lazy var favouriteDrinksCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: 10)
        layout.minimumLineSpacing = 6
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        view.registerReusable(CellType: FavouriteCVCell.self)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //    private lazy var drinksCollectionView: UICollectionView = {
    //        let layout = UICollectionViewFlowLayout()
    //        layout.itemSize = CGSize(width: screenWidth, height: 10)
    //        layout.minimumLineSpacing = 2
    ////        layout.headerReferenceSize = CGSize(width: screenWidth, height: 40)
    ////        layout.footerReferenceSize = CGSize(width: screenWidth, height: 20)
    //        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    //        view.delegate = self
    //        view.dataSource = self
    //        view.registerReusable(CellType: BasketCollectionViewCell.self)
    ////        view.registerReusableView(ViewType: BasketHeaderView.self, type: .UICollectionElementKindSectionHeader)
    ////        view.registerReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter)
    //        view.backgroundColor = ColorConstants.cellBack
    //        return view
    //    }()
    
    
    
    // No Cocktails found Label creating. Appears in case if
    // there is no cocktail found with name that was input.
    private lazy var noCocktailsFoundLabel: UILabel = {
        let label =  UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: favouriteDrinksCV.bounds.size.width,
                height: 50
            )
        )
        label.text = "Oops, there is No cocktail with this name😊\n Maybe you didn't buy it yet?"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = ColorConstants.description
        setupSubViews()
        setUpConstraints()
        favouriteDrinksCV.reloadData()
        configureDrinksCollectionView()
        //        configureSearchDrinkSearchBar()
        //        getDrinksForLetter(currentLetter)
        //        NotificationCenter.post(name: .notificationInfo, object: self, userInfo: drinks)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "post"), object: nil, userInfo: myDict)
    }
    
    private func setupSubViews() {
        view.addSubview(allDrinksTitleLabel)
        view.addSubview(pageInfoSubtitleLabel)
        view.addSubview(searchDrinkSearchBar)
        view.addSubview(backgroundViewForCollection)
        view.addSubview(favouriteDrinksCV)
        view.addSubview(noCocktailsFoundLabel)
    }
    
    // MARK: Configuring methods ()
    private func configureSearchDrinkSearchBar() {
        searchDrinkSearchBar.delegate = self
    }
    
    private func configureDrinksCollectionView() {
        favouriteDrinksCV.register(
            MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuCollectionViewCell.reuseID
        )
        favouriteDrinksCV.delegate = self
        favouriteDrinksCV.dataSource = self
    }
    
    private func updateUIwithSearchResultsState(resultIsEmpty: Bool) {
        if filteredDrinks.isEmpty && !drinks.isEmpty {
            favouriteDrinksCV.isHidden = true
            noCocktailsFoundLabel.isHidden = false
        } else {
            favouriteDrinksCV.isHidden = false
            noCocktailsFoundLabel.isHidden = true
        }
    }
    
    //    @objc func didGetnotification(_ notification: Notification) {
    //        favouriteDrinks.
    //    }
    private var filteredDrinks = [Drinks]() {
        didSet {
            updateUIwithSearchResultsState(resultIsEmpty: filteredDrinks.isEmpty)
            favouriteDrinksCV.reloadData()
        }
    }
    
    // MARK: Call API methods ()
    private func getDrinksForLetter(_ letter: String) {
        Task {
            let drinksFromAPI = try await viewModel.getDrinksForLetter(letter).drinks ?? []
            drinks.append(contentsOf: drinksFromAPI)
        }
    }
    
    private func getDrinksForName(_ name: String) {
        Task {
            filteredDrinks = try await viewModel.getDrinksByName(name).drinks ?? []
        }
    }
    
    // MARK: updateUI() method
    private func setUpConstraints() {
        
        allDrinksTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
        }
        
        pageInfoSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(allDrinksTitleLabel.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            //            make.width.equalTo(232)
            make.height.equalTo(77)
        }
        
        searchDrinkSearchBar.snp.makeConstraints { make in
            make.top.equalTo(pageInfoSubtitleLabel.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        backgroundViewForCollection.snp.makeConstraints { make in
            make.top.equalTo(searchDrinkSearchBar.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(35)
            make.left.right.bottom.equalToSuperview()
        }
        
        favouriteDrinksCV.snp.makeConstraints { make in
            make.top.equalTo(backgroundViewForCollection.snp.top)
            make.left.equalTo(backgroundViewForCollection.snp.left).offset(20)
            make.right.equalTo(backgroundViewForCollection.snp.right).offset(-20)
            make.bottom.equalTo(backgroundViewForCollection.snp.bottom)
        }
        
        noCocktailsFoundLabel.snp.makeConstraints { make in
            make.centerX.equalTo(favouriteDrinksCV.snp.centerX)
            make.centerY.equalTo(favouriteDrinksCV.snp.centerY)
        }
    }
}

extension FavouriteDrinksViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {  notificationArray.count }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = favouriteDrinksCV.dequeueReusableCell(
            withReuseIdentifier: FavouriteCVCell.reuseID,
            for: indexPath
        ) as? FavouriteCVCell else { return UICollectionViewCell() }
        cell.configure(with: notificationArray[indexPath.row])
        //        cell.dispaleo(with: notificationArray[indexPath.row])
        return cell
    }
}

extension FavouriteDrinksViewController: UICollectionViewDelegateFlowLayout {
    private func moveToNextLetter(
        letter: inout String,
        value: inout UInt32
    ) {
        value += 1
        let scalar = UnicodeScalar(value)!
        letter = String(scalar)
    }
    
    private func fetchNextData () {
        moveToNextLetter(
            letter: &currentLetter,
            value: &currentLetterUnicodeVoralue
        )
        getDrinksForLetter(currentLetter)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Check if the user has scrolled to the bottom of the view and it is not
        // searching cocktail process
        let scrollViewContentHeight = favouriteDrinksCV.contentSize.height
        let scrollOffsetThreshold = scrollViewContentHeight - favouriteDrinksCV.bounds.size.height
        
        if scrollView.contentOffset.y > scrollOffsetThreshold,
           searchDrinkSearchBar.text!.isEmpty {
            fetchNextData()
        }
    }
}

extension FavouriteDrinksViewController {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellCustomWidth = (collectionView.bounds.width - 100)
        return CGSize(width: cellCustomWidth, height: cellCustomWidth - 100)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let coctailVC = ChoosedCocktailViewController()
        let model = filteredDrinks[indexPath.row]
        let observe = BehaviorRelay<Drinks>(value: model)
        observe.subscribe(onNext: { drinks in
            coctailVC.cocktail = drinks
            print(coctailVC.cocktail as Any)
        })
        navigationController?.pushViewController(coctailVC, animated: true)
    }
}


extension FavouriteDrinksViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        guard !searchText.isEmpty else { filteredDrinks = drinks; return }
        getDrinksForName(searchText)
    }
}














